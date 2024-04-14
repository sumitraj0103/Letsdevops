variable "workspace_name" {
  description = "The name of the storage account"
}

variable "location" {
  description = "The name of the storage account resource group"
}

variable "resource_group_name" {
  description = "The Azure region where the storage account will be created"

}
variable "hostpoollocation" {
  description = "The name of the storage account"
}

variable "hostpool_name" {
  description = "The name of the storage account"
}

variable "desktop_app_group_name" {
  description = "The name of the storage account resource group"
}
variable "rfc3339" {
type        = string
default     = "2024-04-20T12:43:13Z"
description = "Registration token expiration"
}


