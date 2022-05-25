<!--
Copyright 2022 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->

# Overview

This directory is responsible for building the data pipeline image.

The goal is:

- Build the code into a jar file with all dependencies
- Build the image and publish on Artifact Registry

# Requirements

See [../../README.md](../../README.md) for requirements.

# Usage

Run the following command [at the root of this repository](../..).

```bash
PROJECT=$(gcloud config get-value project)
REGION=us-central1
gcloud builds submit --tag=$REGION-docker.pkg.dev/$PROJECT/simulator/simulator
```