/*
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.healthcare.simulator;

import com.google.common.base.Strings;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.util.IllegalFormatException;
import org.mitre.synthea.engine.Generator;
import org.mitre.synthea.export.FhirR4;
import org.mitre.synthea.helpers.Config;
import org.mitre.synthea.world.agents.Person;

/**
 * Simulator streams fake patient data into a Google Cloud FHIR store.
 *
 * Required Environment Variables:
 *  FHIR_STORE_PATH
 *    The Google Cloud resource path to the FHIR store.  See {@link FhirStoreClient#getFhirStore()}
 *    for details on the expected format.
 *
 * Optional Environment Variables:
 *  POPULATION
 *    The population size to generate.  Defaults to {@link Integer#MAX_VALUE}.
 */
public class Simulator {
  private static final String FHIR_STORE_PATH_ENVIRONMENT_KEY = "FHIR_STORE_PATH";
  private static final String POPULATION_ENVIRONMENT_KEY = "POPULATION";
  private static final String ENTRY_KEY = "entry";
  private static final String RESOURCE_KEY = "resource";
  private static final String RESOURCE_TYPE_KEY = "resourceType";
  private static final Gson GSON = new Gson();
  private static String fhirStorePath = null;
  private static Integer population = Integer.MAX_VALUE;
  private static FhirStoreClient client;

  public static void main(String[] args) throws IOException, InterruptedException {
    parseEnvironmentVariables();
    client = FhirStoreClient
        .builder()
        .setFhirStore(fhirStorePath)
        .build();

    Generator.GeneratorOptions options = new Generator.GeneratorOptions();
    options.population = population;
    Config.set("exporter.fhir.export", "false");
    Config.set("exporter.hospital.fhir.export", "false");
    Config.set("exporter.practitioner.fhir.export", "false");

    Generator generator = new Generator(options);
    for (int i = 0; i < population; i++) {
      Person person = generator.generatePerson(i+1);
      String jsonRecord = FhirR4.convertToFHIRJson(person, person.lastUpdated);
      processRecord(jsonRecord);
    }
  }

  private static void parseEnvironmentVariables() {
    fhirStorePath = System.getenv(FHIR_STORE_PATH_ENVIRONMENT_KEY);
    if (Strings.isNullOrEmpty(fhirStorePath)) throw new IllegalArgumentException(
        String.format("%s empty but expected from environment variables", FHIR_STORE_PATH_ENVIRONMENT_KEY)
    );

    String populationString = System.getenv(POPULATION_ENVIRONMENT_KEY);
    if (!Strings.isNullOrEmpty(populationString)) {
      try {
        population = Integer.parseInt(populationString);
      } catch(IllegalFormatException e) {
        throw new IllegalArgumentException(
            String.format(
                "invalid format for environment variable: %s, got: %s",
                POPULATION_ENVIRONMENT_KEY,
                populationString
            )
        );
      }
    }
  }

  private static void processRecord(String jsonRecord) throws IOException {
    JsonObject jsonObject = GSON.fromJson(jsonRecord, JsonObject.class);
    processRecord(jsonObject);
  }

  private static void processRecord(JsonObject jsonObject) throws IOException {
    if (!jsonObject.has(ENTRY_KEY)) throw new IllegalArgumentException(
        String.format("missing %s property", ENTRY_KEY)
    );
    JsonArray jsonArray = jsonObject.getAsJsonArray(ENTRY_KEY).getAsJsonArray();
    for (JsonElement entry : jsonArray) {
      processEntry(entry);
    }
  }

  private static void processEntry(JsonElement entry) throws IOException {
    JsonObject entryObject = entry.getAsJsonObject();
    if (!entryObject.has(RESOURCE_KEY)) throw new IllegalArgumentException(
        String.format("missing %s property", RESOURCE_KEY)
    );
    JsonObject resource = entryObject.get(RESOURCE_KEY).getAsJsonObject();
    processResource(resource);
  }

  private static void processResource(JsonObject resource) throws IOException {
    if (!resource.has(RESOURCE_TYPE_KEY)) throw new IllegalArgumentException(
        String.format("missing %s property", RESOURCE_TYPE_KEY)
    );

    String resourceType = resource.get(RESOURCE_TYPE_KEY).getAsString();
    String resourceJson = GSON.toJson(resource);
    client.createFhirResource(resourceType, resourceJson);
  }
}
