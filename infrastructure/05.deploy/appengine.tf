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

// Query the virtual private network
data "google_compute_network" "default" {
  name = "simulator"
}

// Query the virtual private subnetwork
data "google_compute_subnetwork" "default" {
  name = "simulator"
  region = var.region
}

// Provision Appengine application
resource "google_app_engine_flexible_app_version" "default" {
  runtime = "custom"
  service = "default"
  version_id = "v1"
  manual_scaling {
    instances = 1
  }

  liveness_check {
    path = ""
  }
  readiness_check {
    path = ""
  }

  deployment {
    container {
      image = "${var.region}-docker.pkg.dev/${var.project}/${var.artifact_registry_id}/${var.app_name}"
    }
  }

  network {
    name = data.google_compute_network.default.name
    subnetwork = data.google_compute_network.default.name
  }

  env_variables = {
    FHIR_STORE_PATH = "projects/${var.project}/locations/${var.region}/datasets/${var.fhirstore_dataset_id}/fhirStores/${var.fhirstore_name}"
  }

  resources {
    cpu = var.cpu
    memory_gb = var.memory_gb
    disk_gb = var.disk_size_gb
    volumes {
      name        = "ramdisk1"
      size_gb     = var.volume_size_gb
      volume_type = "tmpfs"
    }
  }
}