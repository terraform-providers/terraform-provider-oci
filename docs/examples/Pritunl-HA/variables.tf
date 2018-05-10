variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}

variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "ssh_private_key" {}

variable "SubnetOCID" {}

## Choose an Availability Domain
variable "AD" {
  default = "1"
}

variable "InstanceShape1" {
  default = "VM.Standard1.1"
}

variable "InstanceShape" {
  default = "VM.Standard1.2"
}

variable "InstanceOS" {
  default = "Oracle Linux"
}

variable "Image_OCID" {
  default = ""
}

variable "InstanceOSVersion" {
  default = "7.4"
}


