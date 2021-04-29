# Karmada GCP Sandbox

This repo can be used as a Terraform module to build a simple [Karmada](https://github.com/karmada-io/karmada) sandbox in GCP.

## What you get

* 1 GCE with Karmada installed
* 1 GKE

## Requirements

* Service Account with:
  * Compute Admin
  * Container Cluster Admin
  * Network Admin
* SSH Key
* GCP Project

## Setup

First, set environment variables. Replace `PROJECT_ID`, `SERVICE_ACCOUNT_NAME` and `PATH_TO_KEY` with your own values.

Variable | Description 
--- | ---
PROJECT_ID | The ID of the GCP project to use for the sandbox. [Create a project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project) to obtain the ID.
SERVICE_ACCOUNT_NAME | This is the service account that will be created to be used by Terraform
PATH_TO_KEY | Local path where the service account json key will be saved in the form of `/path/filename.json`

```bash
export GCP_PROJECT_ID=PROJECT_ID
export GCP_SERVICE_ACCOUNT=SERVICE_ACCOUNT_NAME
export GCP_SERVICE_ACCOUNT_KEY=PATH_TO_KEY
```

Next, create the service account and assign permissions so it can create Virtual Machines and Kubernetes Clusters within the GCP project.
```bash
gcloud iam service-accounts create ${GCP_SERVICE_ACCOUNT}
gcloud projects add-iam-policy-binding ${GCP_PROJECT_ID} --member=serviceAccount:${GCP_SERVICE_ACCOUNT}@${GCP_PROJECT_ID}.iam.gserviceaccount.com --role=roles/container.clusterAdmin
gcloud projects add-iam-policy-binding ${GCP_PROJECT_ID} --member=serviceAccount:${GCP_SERVICE_ACCOUNT}@${GCP_PROJECT_ID}.iam.gserviceaccount.com --role=roles/compute.admin
gcloud projects add-iam-policy-binding ${GCP_PROJECT_ID} --member=serviceAccount:${GCP_SERVICE_ACCOUNT}@${GCP_PROJECT_ID}.iam.gserviceaccount.com --role=roles/iam.serviceAccountUser
```

The final part of the set up is to create a key for the service account, and set it as an environment variable called GOOGLE_CREDENTIALS which will be picked up by the Terraform Google provider.
```bash
gcloud iam service-accounts keys create ${GCP_SERVICE_ACCOUNT_KEY} --iam-account=${GCP_SERVICE_ACCOUNT}@${GCP_PROJECT_ID}.iam.gserviceaccount.com
export GOOGLE_CREDENTIALS=`cat ${GCP_SERVICE_ACCOUNT_KEY} | tr '\n' ' '`
```

## Building the sandbox

1. Define [required inputs](#terraform-inputs)
2. Terraform init, plan and apply


## Providers

| Name | Version |
|------|---------|
| google | n/a |
| template | n/a |

## Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gce\_machine\_type | Machine type for the Karmada GCE host | `string` | `"n1-standard-2"` | no |
| gce\_name | Name of the Karmada GCE Instance | `string` | `"karmada"` | no |
| gce\_preempt | Enable pre-emptible host for Karmada | `bool` | `true` | no |
| gce\_ssh\_pub\_key\_file | Path to SSH Pub Key file | `any` | n/a | yes |
| gce\_ssh\_user | Username for SSH to GCE instance | `any` | n/a | yes |
| gcp\_project\_id | GCP Project to be used for deployment | `any` | n/a | yes |
| gke\_cluster\_name | Name of the GKE Cluster | `string` | `"member-cluster"` | no |
| karmada\_gke\_count | Number of Member clusters to build | `number` | `1` | no |
| karmada\_install | True/False install Karmada after host build | `bool` | `true` | no |
| karmada\_network | Network name for Karmada | `string` | `"karmada-network"` | no |
| project\_zone | Zone for GCE/GKE | `string` | `"northamerica-northeast1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| karmada\_gce\_host | n/a |

