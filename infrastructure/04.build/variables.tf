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

variable "project" {
  type        = string
  description = "The Google Cloud Platform (GCP) project within which resources are provisioned"
}

variable "region" {
  type        = string
  description = "The Google Cloud Platform (GCP) region in which to provision resources"
  default     = "us-central1"
}

variable "app_name" {
  type        = string
  description = "Name of the application"
  default     = "simulator"
}

variable "full_class_name" {
  type        = string
  description = "The full path and class name of the executable main Java class"
  default     = "com.google.healthcare.simulator.Simulator"
}

variable "github_repository_owner" {
  type        = string
  description = "Owner of the GitHub repository. For example the owner for https://github.com/example/foo is 'example'."
  default     = "google-health"
}

variable "github_repository_name" {
  type        = string
  description = "The name of the GitHub repository. For example the repository name for https://github.com/example/foo is 'foo'."
  default     = "healthcare-streaming-simulator"
}

variable "artifact_registry_id" {
  type        = string
  description = "The ID of the provisioned artifact registry"
  default     = "simulator"
}