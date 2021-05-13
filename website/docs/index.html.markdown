---
layout: "oci"
page_title: "Provider: Oracle Cloud Infrastructure"
sidebar_current: "docs-oci-index"
description: |-
The Oracle Cloud Infrastructure provider is used to interact with the resources supported by the Oracle Cloud Infrastructure services. The provider must be configured with credentials for the Oracle Cloud Account.
---

# Oracle Cloud Infrastructure Provider

The Oracle Cloud Infrastructure (OCI) provider allows you to use Terraform to interact with [Oracle Cloud Infrastructure](https://cloud.oracle.com/cloud-infrastructure) resources. Wherever you use a Terraform distribution you can use the OCI Terraform provider, including [Terraform Cloud](https://www.terraform.io/docs/cloud/index.html) and the OCI [Resource Manager](#resource-manager).

## Terraform CLI

For details on configuring the OCI Terraform provider and using it with the Terraform CLI, refer to the [official OCI Terraform provider documentation](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraform.htm), which includes:

- How to [install the provider](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraforminstallation.htm)
- How to [configure the provider](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm)
- Ways you can [describe your infrastructure](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformdescribingyourinfrastructure.htm)
- How to [apply your configurations](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformapplyingyourconfigurations.htm)
- [Example configurations and solutions](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformexamples.htm)
- Troubleshooting [basics](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformtroubleshootingbasics.htm) and [common issues](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformtroubleshooting.htm)

As you write your configuration files, use the left navigation panel on this page to access detailed information about each supported resource and data source.

## Resource Manager

The Oracle Cloud Infrastructure [Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/landing.htm#ResourceManager) is an Oracle-managed service that is based on Terraform and uses Terraform configuration files to automate deployment and operations for the OCI resources supported by the OCI Terraform provider.

Resource Manager allows you to share and manage infrastructure configurations and state files across multiple teams and platforms. This infrastructure management can't be done with local Terraform installations and Oracle Terraform modules alone. See the [Overview of Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm) for more information.
## Example Usage

```hcl
# Configure the Oracle Cloud Infrastructure provider with an API Key
provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  private_key_path = var.private_key_path
  region = var.region
}

# Get a list of Availability Domains
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

# Output the result
output "show-ads" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

```
More Oracle Cloud Infrastructure provider examples can be found [here](https://github.com/terraform-providers/terraform-provider-oci/tree/master/examples).

##  Sensitive Data May Be Stored In Statefile

> **Warning**: The state contains all resource attributes that are specified as part of configuration files. If you manage any sensitive data with Terraform (like database or user passwords, instance or load balancer private keys, etc), treat the state itself as sensitive data. 
Please refer to [Sensitive Data in State](https://www.terraform.io/docs/state/sensitive-data.html) for more details. 


## Authentication

The OCI provider supports API Key based authentication, Instance Principal based authentication and Security Token authentication.

### API Key based authentication  
Calls to OCI using API Key authentication requires that you provide the following credentials:

- `tenancy_ocid` - OCID of your tenancy. To get the value, see [Required Keys and OCIDs  #Tenancy's OCID](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#five).
- `user_ocid` - OCID of the user calling the API. To get the value, see [Required Keys and OCIDs #User's OCID](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#five).
- `private_key` - The contents of the private key file, required if `private_key_path` is not defined, takes precedence over `private_key_path` if both are defined.
For details on how to create and configure keys see [Required Keys and OCIDs #How to Upload the Public Key](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#three).
- `private_key_path` - The path (including filename) of the private key stored on your computer, required if `private_key` is not defined.
For details on how to create and configure keys see [Required Keys and OCIDs #How to Upload the Public Key](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#three).
- `private_key_password` - (Optional) Passphrase used for the key, if it is encrypted.
- `fingerprint` - Fingerprint for the key pair being used. To get the value, see [Required Keys and OCIDs #How to Get the Key's Fingerprint](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/apisigningkey.htm#four).
- `region` - An Oracle Cloud Infrastructure region. See [Regions and Availability Domains](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm).
- `config_file_profile` - Profile Name if you would like to use custom profile for oci standard config file for credentials

#### Environment variables
It is common to export the above values as environment variables, or source them in different bash profiles when executing 
Terraform commands. Below are OS specific examples for configuring these environment values.

If you primarily work in a single compartment, consider exporting the compartment OCID as well. The tenancy OCID is also 
the OCID of the root compartment, and can be used where any compartment id is required.

##### \*nix
If your Terraform configurations are limited to a single compartment or user, then using this `bash_profile` option be 
sufficient. For more complex environments you may want to maintain multiple sets of environment variables. 
See the [compute single instance example](https://github.com/oracle/terraform-provider-oci/tree/master/examples/compute/instance) for more info.

In your `~/.bash_profile` set these variables:

```
export TF_VAR_tenancy_ocid=<value>
export TF_VAR_compartment_ocid=<value>
export TF_VAR_user_ocid=<value>
export TF_VAR_fingerprint=<value>
export TF_VAR_private_key_path=<value>
``` 

Once you've set these values open a new terminal or source your profile changes:
```
$ source ~/.bash_profile
```

##### Windows

Configuring for Windows usage is largely the same, with one notable exception: you can use PuttyGen to create the public 
and private key as shown above, however, you will need to convert them from PPK format to PEM format.

```
setx TF_VAR_tenancy_ocid <value>
setx TF_VAR_compartment_ocid <value>
setx TF_VAR_user_ocid <value>
setx TF_VAR_fingerprint <value>
setx TF_VAR_private_key_path <value>
```
The variables won't be set for the current session, exit the terminal and reopen.

#### Using the SDK and CLI Configuration File
It is possible to define the required provider values in the same `~/.oci/config` file that the SDKs and CLI support. 
For details on setting up this configuration see [SDK and CLI Configuration File](https://docs.cloud.oracle.com/iaas/Content/API/Concepts/sdkconfig.htm).  

_Note: the parameter names are slightly different. Provider block from terraform config can be completely removed if all API Key based authentication required values are provided as environment variables, in a `*.tfvars file` or `~/.oci/config`_. When using empty provider block, `private_key_password` if required should to be set in `~/.oci/config`. 
 
 If the parameters have multiple sources, the priority is going to be: 1 environment value, 2 non-default profile if provided, 3 DEFAULT profile
 
 To use a non-default profile, you can set it through environment value like: `export TF_VAR_config_file_profile=<value>` or set it in a provider block like:
 
```
provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  config_file_profile= var.config_file_profile
}
```

### Instance Principal Authentication
Instance Principal authentication allows you to run Terraform from an OCI Instance within your Tenancy. To enable Instance 
Principal authentication, set the `auth` attribute to "InstancePrincipal" in the provider definition as below:

```
# Configure the Oracle Cloud Infrastructure provider to use Instance Principal based authentication
provider "oci" {
  auth = "InstancePrincipal"
  region = var.region
}
```

_Note: this configuration will only work when run from an OCI instance. For more information on using Instance 
Principals, see [this document](https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/callingservicesfrominstances.htm)._

Most of the OCI resources need `compartment_id` i.e. the OCID of the parent compartment as a mandatory input argument for provisioning resource in that compartment. Compartment OCID of the instance can be obtained from the [instance metadata](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Tasks/gettingmetadata.htm) endpoint as shown below:
```
data "http" "instance-metadata" {
  url = "http://169.254.169.254/opc/v1/instance/"
}

locals {
  blob = "${replace(data.http.instance-metadata.body, "/\n*/", "")}"
  compartment_id = "${replace(local.blob, "/.*compartmentId\" : \"(.*?)\",.*/", "$1")}"
}
   
output "instance-compartment" {
  value = "${local.compartment_id}"
}
```

### Security Token Authentication
Security Token authentication allows you to run Terraform using a token generated with [Token-based Authentication for the CLI](https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/clitoken.htm).
To enable Security Token authentication, set the `auth` attribute to "SecurityToken" and provide a value for `config_file_profile` in the provider definition. For example:

```
# Configure the Oracle Cloud Infrastructure provider to use Security Token authentication
provider "oci" {
  auth                = "SecurityToken"
  config_file_profile = "PROFILE"
}
```

_Note: This token expires after 1 hour. Avoid using this authentication when provisioning of resources takes longer than 1 hour. 
To refresh the security token, see [this document](https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/clitoken.htm#RefreshingaToken)._

## Configuring Automatic Retries
While applying, refreshing, or destroying a plan, Terraform may encounter some intermittent OCI errors (such as 429 or 500 errors) that could succeed on retry. 
By default, the Terraform OCI provider will automatically retry such operations for up to 10 minutes. 
The following fields can be specified in the provider block to further configure the retry behavior:

- `disable_auto_retries` - Disable automatic retries for retriable errors.
- `retry_duration_seconds` - The minimum duration (in seconds) to retry a resource operation in response to HTTP 429 and HTTP 500 errors. The actual retry duration may be slightly longer due to the jittering of retry operations. This value is ignored if the `disable_auto_retries` field is set to true.

### Concurrency Control using Retry Backoff and Jitter
To alleviate contention between parallel operations against OCI services; the Terraform OCI provider schedules retry attempts using quadratic backoff and full jitter.
Quadratic backoff increases the maximum interval between subsequent retry attempts, while full jitter randomly selects a retry interval within the backoff range.

For example, the wait time between the 1st and 2nd retry attempts is chosen randomly between 1 and 8 seconds. The wait time between the 2nd and 3rd retry attempts is chosen
randomly between 1 and 18 seconds. Regardless of the number of retry attempts, the retry interval time is capped after the 12th attempt at 288 seconds.

Note that the `retry_duration_seconds` field only affects retry duration in response to HTTP 429 and 500 errors; as these errors are more likely to result in success after a long retry duration.
Other HTTP errors (such as 400, 401, 403, 404, and 409) are unlikely to succeed on retry. The `retry_duration_seconds` field does not affect the retry behavior for such errors.
