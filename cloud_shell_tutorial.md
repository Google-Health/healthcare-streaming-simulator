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

It will ask your permission before provisioning resources and you'll need to
type `yes` to proceed.

```sh
DIR=infrastructure/01.setup
terraform -chdir=$DIR init
terraform -chdir=$DIR apply -var='project=<walkthrough-project-id/>'
```

## 2. Provision network

Run the terraform workflow in
the [infrastructure/02.network](infrastructure/02.network) directory.

It will ask your permission before provisioning resources and you'll need to
type `yes` to proceed.

```sh
DIR=infrastructure/02.network
terraform -chdir=$DIR init
terraform -chdir=$DIR apply -var='project=<walkthrough-project-id/>'
```

## 3. Provision FHIR Store and related resources

It will ask your permission before provisioning resources and you'll need to
type `yes` to proceed.

Run the terraform workflow in
the [infrastructure/03.sinks](infrastructure/03.sinks) directory.

```sh
DIR=infrastructure/03.sinks
terraform -chdir=$DIR init
terraform -chdir=$DIR apply -var='project=<walkthrough-project-id/>'
```

## 4. Build the Docker image

Run the following command to build the Docker image.

```sh
REGION=us-central1
gcloud builds submit --tag=$REGION-docker.pkg.dev/<walkthrough-project-id/>/simulator/simulator
```

## 5. Deploy the application

Run the terraform workflow in
the [infrastructure/05.deploy](infrastructure/05.deploy) directory.

It will ask your permission before provisioning resources and you'll need to
type `yes` to proceed.

```sh
DIR=infrastructure/05.deploy
terraform -chdir=$DIR init
terraform -chdir=$DIR apply -var='project=<walkthrough-project-id/>'
```

## Summary

The application will start populating FHIR Store.  Notifications are sent to
the Pub/Sub topic and data mirrored on the BigQuery dataset.

The following are where you can find resources you just deployed:

- [Pub/Sub Topic](https://console.cloud.google.com/cloudpubsub/topic/list?project=<walkthrough-project-id/>)
- [Pub/Sub Subscription](https://console.cloud.google.com/cloudpubsub/subscription/list?project=<walkthrough-project-id/>)
- [BigQuery dataset](https://console.cloud.google.com/bigquery?project=<walkthrough-project-id/>)
- [FHIR Store](https://console.cloud.google.com/healthcare/browser?project=<walkthrough-project-id/>)
- [Docker image](https://console.cloud.google.com/artifacts?project=<walkthrough-project-id/>)
- [Appengine Instance](https://console.cloud.google.com/appengine/instances?project=<walkthrough-project-id/>)