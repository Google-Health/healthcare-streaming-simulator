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

// Provision Pub/Sub topic to which FHIR store will publish notifications
resource "google_pubsub_topic" "default" {
  name = var.pubsub_topic
}

// Provision Pub/Sub subscription of FHIR store notifications
resource "google_pubsub_subscription" "default" {
  name  = var.pubsub_subscription
  topic = google_pubsub_topic.default.name
}