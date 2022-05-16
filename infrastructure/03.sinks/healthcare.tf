# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

// Query current Google Cloud project metadata
data "google_project" "default" {}

// Provision a FHIR dataset
resource "google_healthcare_dataset" "default" {
  name     = var.fhirstore_dataset_id
  location = var.region
}

// Provision a FHIR store with notification and streaming configurations
resource "google_healthcare_fhir_store" "default" {
  dataset                       = google_healthcare_dataset.default.id
  name                          = var.fhirstore_name
  version                       = var.fhir_store_version
  notification_config {
    pubsub_topic = google_pubsub_topic.default.id
  }
  disable_referential_integrity = false
  enable_update_create          = true

  stream_configs {
    bigquery_destination {
      dataset_uri = "bq://${var.project}.${google_bigquery_dataset.default.dataset_id}"
      schema_config {
        recursive_structure_depth = var.bigquery_dataset_stream_config_recursive_structure_depth
      }
    }
  }
}