# General Configuration
variable "namespace" {
  description = "(Optional) namespace of the resources default to lambda"
  type        = "string"
  default     = "lambda"
}

variable "tags" {
  description = "(Optional) tags for resources default CreatedBy=Terraform"
  type        = "map"
  default     = {
    CreatedBy = "Terraform"
  }
}

# Cognito User Pools configuration
variable "user_pool_id" {
  description = "(Required) The user pool id"
  type        = "string"
}

variable "user_pool_region" {
  description = "(Required) The region where the user pool is in"
  type        = "string"
}


variable "client_id" {
  description  = "(Required) The client id"
  type         = "string"
}