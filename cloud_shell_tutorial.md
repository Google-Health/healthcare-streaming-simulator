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

## Select or create project

Select or create a project to begin.

<walkthrough-project-setup></walkthrough-project-setup>

## Set default project

```sh
gcloud config set project <walkthrough-project-id/>
```

## 1. Setup environment

Run the terraform workflow in
the [infrastructure/01.setup](infrastructure/01.setup) directory.

```sh
DIR=infrastructure/01.setup
terraform -chdir=$DIR init
terraform apply -chdir=$DIR -var='project=<walkthrough-project-id/>'
```

## 2. Provision network

Run the terraform workflow in
the [infrastructure/02.network](infrastructure/02.network) directory.

```sh
DIR=infrastructure/02.network
terraform -chdir=$DIR init
terraform apply -chdir=$DIR -var='project=<walkthrough-project-id/>'
```

## 3. Provision FHIR Store and related resources

Run the terraform workflow in
the [infrastructure/03.sinks](infrastructure/03.sinks) directory.

```sh
DIR=infrastructure/03.sinks
terraform -chdir=$DIR init
terraform apply -chdir=$DIR -var='project=<walkthrough-project-id/>'
```

## 4. Build the Docker image

Run the terraform workflow in
the [infrastructure/04.build](infrastructure/04.build) directory.

```sh
DIR=infrastructure/04.build
terraform -chdir=$DIR init
terraform apply -chdir=$DIR -var='project=<walkthrough-project-id/>'
```

## 5. Deploy the application

Run the terraform workflow in
the [infrastructure/05.deploy](infrastructure/05.deploy) directory.

```sh
DIR=infrastructure/05.deploy
terraform -chdir=$DIR init
terraform apply -chdir=$DIR -var='project=<walkthrough-project-id/>'
```

## Summary

The following are where you can find resources you just deployed:

- https://console.cloud.google.com/cloudpubsub/topic/list?project=<walkthrough-project-id/>
- https://console.cloud.google.com/cloudpubsub/subscription/list?project=<walkthrough-project-id/>
- https://console.cloud.google.com/healthcare/browser?project=<walkthrough-project-id/>
- https://console.cloud.google.com/appengine/instances?project=<walkthrough-project-id/>