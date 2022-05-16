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

// Provision a Cloud Build trigger to build the Dataflow Custom template
resource "google_cloudbuild_trigger" "dataflow_template_build_trigger" {
  name = "simulator"
  source_to_build {
    uri       = "https://github.com/${var.github_repository_owner}/${var.github_repository_name}"
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }
  build {
    timeout = "1800s"
    step {
      id   = "healthcare:simulator:build_image"
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build",
        "-t",
        "${var.region}-docker.pkg.dev/${var.project}/${var.artifact_registry_id}/${var.app_name}",
        "."
      ]
    }
    images  = [
      "${var.region}-docker.pkg.dev/${var.project}/${var.artifact_registry_id}/${var.app_name}",
    ]
  }
}