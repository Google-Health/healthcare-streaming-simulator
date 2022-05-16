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

variable "app_name" {
  type        = string
  description = "Name of the application"
  default     = "simulator"
}

variable "artifact_registry_id" {
  type        = string
  description = "The ID of the provisioned artifact registry"
  default     = "simulator"
}

variable "cpu" {
  type = number
  description = "Number of CPU cores needed"
  default = 4
}

variable "disk_size_gb" {
  type = number
  description = "Disk size (GB) needed"
  default = 10
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

variable "memory_gb" {
  type = number
  description = "Memory (GB) needed"
  default = 16
}

variable "project" {
  type        = string
  description = "The Google Cloud Platform (GCP) project within which resources are provisioned"
}

variable "region" {
  type        = string
  description = "The Google Cloud Platform (GCP) region in which to provision resources"
  default = "us-central1"
}

variable "volume_size_gb" {
  type = number
  description = "Volume size in gigabytes"
  default = 1
}