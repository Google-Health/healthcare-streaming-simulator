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

# Deploy the Healthcare Streaming Simulator

## Setup project

Run the terraform workflow in
the [infrastructure/01.setup](infrastructure/01.setup) directory.

```sh
PROJECT=$(gcloud config get-value project)
cd infrastructure/01.setup
terraform init
terraform apply -var='project=$PROJECT'
```

## Provision network

Run the terraform workflow in
the [infrastructure/02.network](infrastructure/02.network) directory.

```sh
PROJECT=$(gcloud config get-value project)
cd infrastructure/02.network
terraform init
terraform apply -var='project=$PROJECT'
```

## Provision FHIR Store and related resources

Run the terraform workflow in
the [infrastructure/03.sinks](infrastructure/03.sinks) directory.

```sh
PROJECT=$(gcloud config get-value project)
cd infrastructure/03.sinks
terraform init
terraform apply -var='project=$PROJECT'
```

## Build the Docker image

Run the terraform workflow in
the [infrastructure/04.build](infrastructure/04.build) directory.

```sh
PROJECT=$(gcloud config get-value project)
cd infrastructure/04.build
terraform init
terraform apply -var='project=$PROJECT'
```

## Deploy the application

Run the terraform workflow in
the [infrastructure/05.deploy](infrastructure/05.deploy) directory.

```sh
PROJECT=$(gcloud config get-value project)
cd infrastructure/05.deploy
terraform init
terraform apply -var='project=$PROJECT'
```
