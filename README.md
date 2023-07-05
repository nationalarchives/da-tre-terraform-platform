# TRE Terraform Platform

Terraform IaC configuration to deploy AWS resources that must be created
before the TRE v2 application can be deployed from repository
[tre-terraform-environments](https://github.com/nationalarchives/tre-terraform-environments).

* [Overview](#overview)
  * [Repository Structure](#repository-structure)
  * [Target AWS Environments](#target-aws-environments)
  * [Terraform Input Variables](#terraform-input-variables)
  * [Terraform Remote State](#terraform-remote-state)
  * [GitHub Action Workflow](#github-action-workflow)
  * [GitHub AWS Access](#github-aws-access)
    * [OpenID Connect](#openid-connect)
    * [AWS and GitHub Environments](#aws-and-github-environments)
    * [GitHub Secrets](#github-secrets)
* [Running Terraform](#running-terraform)
  * [Running Terraform Via GitHub Actions](#running-terraform-via-github-actions)
  * [Running Terraform CLI Locally](#running-terraform-cli-locally)

# Overview

## Repository Structure

The repository has the following separate deployment folders:

| Deployment Folder            | Description                                                   |
| ---------------------------- | ------------------------------------------------------------- |
| [`./platform`](platform)     | Deploys TRE platform-level AWS resources                      |
| [`./tf-backend`](tf-backend) | Deploys configuration to grant GitHub Action terraform access |

## Target AWS Environments

This repository's IaC configuration is used to create and manage TRE platform
(i.e. non TRE application) AWS resources across the following AWS accounts:

* AWS Account: **`management`** <sup>e.g. IAM roles, CloudWatch log groups, etc</sup>
  * AWS Account: **`non-prod`** <sup>e.g. IAM roles, CloudTrail configuration, etc</sup>
  * AWS Account: **`prod`** <sup>e.g. IAM roles, CloudTrail configuration, etc</sup>

## Terraform Input Variables

The values used to set Terraform input variables are held in AWS Parameter
Store parameters on on a per-deployment basis (in JSON format); these are:

| Deployment   | Parameter               |
| ------------ | ----------------------- |
| `platform`   | `tre-platform-tfvars`   |
| `tf-backend` | `tre-tf-backend-tfvars` |

The GitHub Action workflow saves the appropriate parameter value to a
temporary `terraform.tfvars.json` file for subsequent use (e.g. to run
`terraform plan -var-file="terraform.tfvars.json"`).

## Terraform Remote State

This deployment uses a Terraform
[remote state](https://developer.hashicorp.com/terraform/language/state/remote),
with each deployment component (`tf-backend` and `platform`) having a
separate Terraform [workspace](https://developer.hashicorp.com/terraform/language/state/workspaces).

The state and workspace info is held in an `s3` bucket in the TRE management
account; i.e.:

```bash
~ % aws s3 ls "${TRE_TF_STATE_S3_BUCKET}"
                           PRE env:/
~ % aws s3 ls "${TRE_TF_STATE_S3_BUCKET}/env:/"
                           PRE platform/
                           PRE tf-backend/
~ %
```

An AWS [DynamoDB](https://aws.amazon.com/dynamodb) table is used for Terraform
[state locking](https://developer.hashicorp.com/terraform/language/state/locking).

## GitHub Action Workflow

The Terraform configuration in this repository can be deployed by manually
triggering the following workflow:

* [`tre-platform-deployment.yml`](.github/workflows/tre-platform-deployment.yml) <sup>this repo</sup>
  * [`tf-plan-approve-apply.yml`](https://github.com/nationalarchives/da-tre-github-actions/blob/main/.github/workflows/tf-plan-approve-apply.yml) <sup>[tre-github-actions repo](https://github.com/nationalarchives/tre-github-actions)</sup>

The workflow controls deployment, with manual checkpoints allowing
configuration changes to be verified before they are applied.

The following section describes how to run the workflow:

* [Running Terraform Via GitHub Actions](#running-terraform-via-github-actions)

## GitHub AWS Access

### OpenID Connect

[OpenID connect](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
is used to grant GitHub Action workflows access to AWS; this:

* Allows Terraform to use [remote state](https://developer.hashicorp.com/terraform/language/state/remote) `s3` and `DynamoDB` resources
* Allows Terraform to configure TRE AWS entities

The ARN of the AWS role used for access control is stored in the `ROLE_ARN`
environment-level secret (see [GitHub Secrets](#github-secrets) below).

### AWS and GitHub Environments

GitHub environment resources are configured to hold secrets for each of this
repository's deployment folders and to define manual approval steps.

The table below shows this repository's configured GitHub environments:

| Deployment Name | GitHub Environment Name  | Description                                                                                 |
| --------------- | ------------------------ | ------------------------------------------------------------------------------------------- |
| platform        | apply-tf-plan-platform   | Defines the list of users allowed to permit `terraform apply` for the platform deployment   |
| platform        | platform                 | Holds platform deployment specific secrets                                                  |
| tf-backend      | apply-tf-plan-tf-backend | Defines the list of users allowed to permit `terraform apply` for the tf-backend deployment |
| tf-backend      | tf-backend               | Holds tf-backend deployment specific secrets                                                |

### GitHub Secrets

The following GitHub secrets are used when running the GitHub Action workflow:

| Secret                         | Level         | Description |
| ------------------------------ | ------------- | ----------- |
| AWS_PARAM_STORE_TF_BACKEND_KEY | `repository`  | The name of the AWS Parameter Store parameter whose value is written to a temporary `backend.conf` file (for use in `terraform init -backend-config=backend.conf ...`) |
| SLACK_TOKEN                    | `repository`  | Slack Webhook URL used to send notifications to Slack                                                                                                                  |
| ROLE_ARN                       | `environment` | The ROLE_ARN secrets (there is one for each environment) hold the ARN of the AWS IAM Role used by OpenID Connect to grant access to GitHub                             |

# Running Terraform

## Running Terraform Via GitHub Actions

To manually trigger this repository's deployment workflow:

* Navigate to the repository's GitHub [`actions`](https://github.com/nationalarchives/da-tre-terraform-platform/actions) tab
* Select the [`Terraform platform deployment`](`https://github.com/nationalarchives/da-tre-terraform-platform/actions/workflows/tre-platform-deployment.yml`) action from the side menu
* Click the grey `Run workflow` drop-down button
* Select the branch holding the configuration to be applied (typically `main`)
* Select the deployment that is to be applied, i.e. `platform` or `tf-backend`
* Click the green `Run workflow` button
* The workflow will pause at the `apply-tf-plan-to-*` checkpoint, verify the
  `terraform plan` output (a link is sent to Slack) and approve or reject
  accordingly

Errors encountered in workflow execution are sent to AWS CloudWatch logs (so
they can't be viewed in the public GitHub console). Errors can be viewed in the
TRE AWS management account at the following location:

* CloudWatch
  * Log Groups
    * Log group: `tre-github-actions-error`

## Running Terraform CLI Locally

> **Warning**
>
> Terraform should only be run locally to check the plan. No `terraform`
> commands that update the remote state should be run locally. Updates to the
> TRE environments should only be applied using the
> [GitHub Action workflow](#running-terraform-via-github-actions).

* Navigate to this project's `platform` or `tf-backend` deployment directory
  (this guide will use the `platform` directory):

  ```bash
  cd platform
  ```

* Create a Terraform backend configuration file with the appropriate values:

  ```bash
  TRE_TF_STATE_S3_BUCKET=
  TRE_TF_STATE_KEY='terraform.tfstate'
  TRE_TF_AWS_REGION=
  TRE_TF_DYNAMODB_TABLE=
  TRE_TF_ENCRYPT='true'
  TRE_TF_AWS_ACCOUNT_ID=
  TRE_TF_ACCESS_ROLE=

  cat <<EOF > backend.conf
  bucket="${TRE_TF_STATE_S3_BUCKET:?}"
  key="${TRE_TF_STATE_KEY:?}"
  region="${TRE_TF_AWS_REGION:?}"
  dynamodb_table="${TRE_TF_DYNAMODB_TABLE:?}"
  encrypt=${TRE_TF_ENCRYPT:?}
  role_arn="arn:aws:iam::${TRE_TF_AWS_ACCOUNT_ID:?}:role/${TRE_TF_ACCESS_ROLE:?}"
  EOF
  ```

  > An `external_id` key will also need to be added to the `backend.conf`
    file if the `role_arn` has been configured to require one

* Set your `AWS_PROFILE` environment variable to an account with permission to
  assume the role defined by `role_arn` in `backend.conf` (and export it):

  ```bash
  export AWS_PROFILE=...
  ```

* Initialise Terraform:

  ```bash
  terraform init -backend-config=backend.conf
  ```

* Select the `platform` Terraform workspace (use `terraform workspace list` to view):

  ```bash
  # Use 'platform' or 'tf-backend'
  TRE_TF_WORKSPACE='platform'

  terraform workspace select "${TRE_TF_WORKSPACE:?}"
  ```

  > The current state can now be viewed with `terraform show`

* Create a file to set the values for the project's Terraform input variables:

  > Your `AWS_PROFILE` must permit access to retrieve the parameter

  ```bash
  # Use 'tre-platform-tfvars' or 'tre-tf-backend-tfvars'
  TRE_TFVAR_PARAM='tre-platform-tfvars'

  aws ssm \
  get-parameters \
    --name "${TRE_TFVAR_PARAM:?}" \
    --with-decryption \
    --output text \
    --no-cli-pager \
    --query Parameters[*].Value \
  > terraform.tfvars.json
  ```

* Edit the `terraform.tfvars.json` file and ensure the `assume_role` role
  names for each account are set to appropriate values for your setup

* Generate a speculative execution plan with:

  ```bash
  terraform plan \
    -var-file=terraform.tfvars.json \
    -input=false \
    -out=plan.out
  ```
