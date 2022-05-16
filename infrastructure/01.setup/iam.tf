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

// Bind minimally necessary IAM roles to Cloud Build service agent
resource "google_project_iam_member" "cloud_build_roles" {
  depends_on = [google_project_service.required_services]
  for_each   = toset([
    "roles/storage.objectViewer"
  ])
  role       = each.key
  member     = "serviceAccount:${data.google_project.default.number}@cloudbuild.gserviceaccount.com"
  project    = var.project
}

// Bind minimally necessary IAM roles to Healthcare Service Agent
resource "google_project_iam_member" "healthcare_service_agent_roles" {
  depends_on = [google_project_service.required_services]
  for_each   = toset([
    "roles/healthcare.fhirResourceEditor",
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser"
  ])
  role       = each.key
  member     = "serviceAccount:service-${data.google_project.default.number}@gcp-sa-healthcare.iam.gserviceaccount.com"
  project    = var.project
}

// Bind minimally necessary IAM roles to the default Appengine Service Agent
resource "google_project_iam_member" "default_appengine_service_agent_roles" {
  depends_on = [google_project_service.required_services]
  for_each   = toset([
    "roles/healthcare.fhirResourceEditor",
    "roles/appengineflex.serviceAgent",
    "roles/storage.objectViewer",
    "roles/artifactregistry.reader"
  ])
  role       = each.key
  member     = "serviceAccount:${var.project}@appspot.gserviceaccount.com"
  project    = var.project
}
