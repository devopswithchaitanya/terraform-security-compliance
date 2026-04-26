variable "aws_region"        { type = string; default = "eu-central-1" }
variable "project"           { type = string; default = "devops-app" }
variable "environment"       { type = string; default = "dev" }
variable "allowed_iam_roles" { type = list(string); default = [] }
