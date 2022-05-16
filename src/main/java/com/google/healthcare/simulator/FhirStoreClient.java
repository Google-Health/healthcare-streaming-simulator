package com.google.healthcare.simulator;

import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.healthcare.v1.CloudHealthcare;
import com.google.api.services.healthcare.v1.CloudHealthcareScopes;
import com.google.api.services.healthcare.v1.model.HttpBody;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auto.value.AutoValue;
import java.io.IOException;
import java.io.Serializable;
import com.google.auth.oauth2.GoogleCredentials;

/**
 * The {@link FhirStoreClient} writes to a FHIR Store resource in Google Cloud.
 */
@AutoValue
abstract class FhirStoreClient implements Serializable {
  private static final int REQUEST_TIMEOUT = 60000;

  static Builder builder() {
    return new AutoValue_FhirStoreClient.Builder();
  }

  private static final String APPLICATION_NAME = "simulator";
  private static final JsonFactory PARSER = new GsonFactory();

  private transient CloudHealthcare client;

  /**
   * The getter for the Google Cloud FHIR Store path.
   *
   * The expected format is projects/{project}/locations/{location}/datasets/{dataset}/fhirStores/{fhirStore}
   * Run gcloud healthcare fhir-stores describe {fhirStore} --dataset={dataset}
   * to get the full path from the name property.
   */
  abstract String getFhirStore();

  private void initClient() throws IOException {
    GoogleCredentials credentials = GoogleCredentials.getApplicationDefault().createScoped(
        CloudHealthcareScopes.CLOUD_PLATFORM
    );
    HttpRequestInitializer requestInitializer = request -> {
      new HttpCredentialsAdapter(credentials).initialize(request);
      request.setConnectTimeout(REQUEST_TIMEOUT);
      request.setReadTimeout(REQUEST_TIMEOUT);
    };
    client =
        new CloudHealthcare.Builder(
            new NetHttpTransport(), new GsonFactory(), requestInitializer)
            .setApplicationName(APPLICATION_NAME)
            .build();
  }

  /**
   * Creates a FHIR resource in Google Cloud FHIR Store.
   *
   * See https://cloud.google.com/healthcare-api/docs/how-tos/fhir-resources#creating_a_fhir_resource
   * for more detail on creating a FHIR resource.
   */
  void createFhirResource(String resourceType, String data) throws IOException {
    if (client == null) {
      initClient();
    }
    HttpBody httpBody = PARSER.fromString(data, HttpBody.class);

    client
        .projects()
        .locations()
        .datasets()
        .fhirStores()
        .fhir()
        .create(getFhirStore(), resourceType, httpBody)
        .execute();
  }

  /** The {@link FhirStoreClient} Builder. */
  @AutoValue.Builder
  static abstract class Builder {

    /**
     * The setter for the Google Cloud FHIR Store path.
     *
     * The expected format is projects/{project}/locations/{location}/datasets/{dataset}/fhirStores/{fhirStore}
     * Run gcloud healthcare fhir-stores describe {fhirStore} --dataset={dataset}
     * to get the full path from the name property.
     */
    abstract Builder setFhirStore(String value);

    /** Builds a {@link FhirStoreClient}. */
    abstract FhirStoreClient build();
  }
}