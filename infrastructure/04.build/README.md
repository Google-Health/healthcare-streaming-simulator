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

This module is responsible for building the data pipeline image.

This module achieves the following:

- Builds the code into a jar file with all dependencies
- Build the image and publish on Artifact Registry

# Requirements

- If this repository is cloned into a private repo, 
connect GitHub repository as explained in
[Installing the Cloud Build app](https://cloud.google.com/build/docs/automating-builds/build-repos-from-github#installing_gcb_app).
**YOU CAN IGNORE CREATING THE TRIGGER**

# Usage

Follow conventional terraform workflow to build this solution. You will be
prompted for required variables. Alternatively, you may create a `vars.tfvars`
file and apply the `-var-file=vars.tfvars` flag.

## Terraform init

Initialize the terraform environment.

```
terraform init
```

## Terraform plan

Plan the terraform solution.

```
terraform plan
```

or

```
terraform plan -var-file=vars.tfvars
```

## Terraform apply

Apply the terraform solution.

```
terraform apply
```

or

```
terraform apply -var-file=vars.tfvars
```

## Trigger Build

Follow instructions found on
https://cloud.google.com/build/docs/automating-builds/create-manual-triggers#running_manual_triggers

to run the manual trigger created from this module.