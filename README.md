# Harpocrates
<!-- TOC -->

- [Harpocrates](#harpocrates)
    - [Intro](#intro)
        - [Chamber](#chamber)
        - [Parameter Store](#parameter-store)
    - [Usage](#usage)
        - [Outputs](#outputs)
        - [Random provider](#random-provider)
    - [Chamber KMS Key Alias](#chamber-kms-key-alias)

<!-- /TOC -->

## Intro

In any infrastructure we have senstive information that needs to be store and distributed to services and instances in order operations and authentication occur.

Well known systems to store these secrets are [Hashicorp's Vault](https://www.vaultproject.io/) and [Kubernets Secrets](https://kubernetes.io/docs/concepts/configuration/secret/). 

In this [Terraform](https://www.terraform.io/) module we implement Infrastructure as Code to easily deploy Chamber.

### Chamber

[Segment's Chamber](https://github.com/segmentio/chamber/) is a tool for managing secrets. Currently it does so by storing secrets in [SSM Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html), an AWS service for storing secrets. 

### Parameter Store

Parameter Store security and encryption is powered by [AWS KMS](https://aws.amazon.com/blogs/aws/new-key-management-service/), a managed service that makes it easy for you to create and control the encryption keys used to encrypt your data, and uses Hardware Security Modules (HSMs).

## Usage

In your terraform state, add a new module resource:

```
module "chamber-test" {
  source = "github.com/yopaproperty/harpocrates/"

  region           = "${var.region}"
  AccountID        = "${var.AccountID}"
  IAMAccountID     = "${var.IAMAccountID}"
  kms_alias_prefix = "My-Company-kms-prefix-test"
  ssm_prefix       = "My-Company-keys-prefix-test"
}
```

As seen in the example above and in the module `variables.tf`, you are required to provide the following variables:

- region

> SSM Parameter Store is a regional service and as such it is required to specify a Region.

- AccountID

> The AWS Account ID of the account where you intend to deploy SSM and KMS.

> You can use a Data Source [aws_caller_identity](https://www.terraform.io/docs/providers/aws/d/caller_identity.html) to obtain an output and maintain your code dynamic.

- IAMAccountID

> The AWS IAM Account ID to allow STS:AssumeRole cross account to KMS and SSM roles.

- kms_alias_prefix

> In order not to clash with existing KMS keys and allow fine grained control policies, a custom prefix is required.

- ssm_prefix

> In order not to clash with existing SSM keys and allow fine grained control policies, a custom prefix is required.


### Outputs

Once `$ terraform init && terraform apply` is executed the following resources will be created:

- A KMS Key
- A KMS Key Alias
- A SSM Parameter Store Key
- A KMS Admin Role
- A KMS Manage Role
- A KMS Read Role
- A SSM Manage Role
- A SSM Read Role
- A ECS service Read Role
- A EC2 Read Role

### Random provider

A `Terraform Random provider` [resource](https://www.terraform.io/docs/providers/random/r/pet.html) is used as suffix to resources, allowing multiple invocations without name clashing.

## Chamber KMS Key Alias

Following Chamber [Usage Guide](https://github.com/segmentio/chamber/#setting-up-kms), you are made aware that Chamber expects to find a KMS key with alias `parameter_store_key` in the account that you are writing/reading secrets.

When deploying this terraform module, we create unique KMS Key Alias, allowing multiple SSM key stores to exist, each with their own KMS key.

As such when operating Chamber you *must* export an enviroment variable for `CHAMBER_KMS_KEY_ALIAS` with the contents of the specific KMS Key Alias of the resource you created.

You can find those by running `$ terraform output | grep aws_kms_alias_name`

ex: `preprod_aws_kms_alias_name = alias/my-company-preprod-notable-elastic`