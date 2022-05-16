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

variable "bigquery_dataset_id" {
  type        = string
  description = "The BigQuery dataset to stream updates from FHIR Store via stream config"
  default     = "synthea"
}

variable "bigquery_dataset_stream_config_recursive_structure_depth" {
  type        = number
  description = "The depth for all recursive structures in the output analytics schema. See https://cloud.google.com/healthcare-api/docs/reference/rest/v1/projects.locations.datasets.fhirStores#SchemaConfig for details."
  default     = 2
}

variable "fhirstore_dataset_id" {
  type        = string
  description = "The dataset containing the FHIR store"
  default     = "synthea"
}

variable "fhirstore_name" {
  type        = string
  description = "The name of the FHIR store"
  default     = "synthea"
}

variable "fhir_store_version" {
  type        = string
  description = "The FHIR specification version"
  default     = "R4"
}

variable "project" {
  type        = string
  description = "The Google Cloud Platform (GCP) project within which resources are provisioned"
}

variable "pubsub_topic" {
  type        = string
  description = "The topic of the Pub/Sub to sent FHIR store notifications"
  default     = "synthea"
}

variable "pubsub_subscription" {
  type        = string
  description = "The subscription of the Pub/Sub to receive FHIR store notifications"
  default     = "synthea-sub"
}

variable "region" {
  type        = string
  description = "The Google Cloud Platform (GCP) region in which to provision resources"
  default     = "us-central1"
}

variable "simulator_service_account_id" {
  type        = string
  description = "The service account ID provisioned to the simulator workload"
  default     = "simulator"
}