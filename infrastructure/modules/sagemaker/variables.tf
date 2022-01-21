variable "repository_name" {
  type = string
}

variable "repository_url" {
  type = string
}

variable "notebook_instance_name" {
  type = string
}

variable "instance_type" {
  type = string
  default = "ml.t2.medium"
}

variable "s3_bucket_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}
