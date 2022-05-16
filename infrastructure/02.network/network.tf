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

// Provision virtual private network
resource "google_compute_network" "default" {
  name                    = "simulator"
  auto_create_subnetworks = false
}

// Provision a single subnetwork in a configured region
resource "google_compute_subnetwork" "default" {
  name                     = "simulator"
  ip_cidr_range            = var.subnetwork_cidr_range
  network                  = google_compute_network.default.name
  private_ip_google_access = true
  region                   = var.region
}

// Allow internal network traffic within virtual private network
resource "google_compute_firewall" "default" {
  name    = "allow-simulator-internal"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
  }
  source_tags = ["simulator"]
}