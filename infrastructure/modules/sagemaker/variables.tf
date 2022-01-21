variable "repository_name" {
  type    = string
  default = "data-application-example"
}

variable "repository_url" {
  type    = string
  default = "https://github.com/n1nj4-r4cc00n/data-application-example.git"
}

variable "notebook_instance_name" {
  type    = string
  default = "deleteme123456789"
}

variable "instance_type" {
  type    = string
  default = "ml.t2.medium"
}

variable "s3_bucket_name" {
  type    = string
  default = "deleteme123456789"
}


variable "tags" {
  type    = map(string)
  default = {}
}
