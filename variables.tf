variable "ruta_local" {
  type = string
  description = "value of the local path to upload the files"
}

variable "region" {
  type = string
  description = "value of the region to create the resources"
}

variable "profile" {
  type = string
  description = "value of the aws profile to use"
}

variable "group_tf_storage" {
  type = string
  description = "value of the resource group"
}

variable "name_s3_bucket" {
  type = string
  description = "value of the s3 bucket name"
}