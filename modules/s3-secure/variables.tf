variable "bucket_name"    { type = string }
variable "environment"    { type = string }
variable "project"        { type = string }
variable "kms_key_id"     { type = string; default = "" }
variable "allowed_roles"  { type = list(string); default = [] }
