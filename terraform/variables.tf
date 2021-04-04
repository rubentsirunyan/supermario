variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "project_name" {
  type    = string
  default = "supermario"
}

variable "service_name" {
  type    = string
  default = "main"
}

variable "cidrs" {
  type = map(string)
  default = {
    prod = "10.11.0.0/16"
    dev  = "10.12.0.0/16"
  }
}

variable "image" {
  type    = string
  default = "bharathshetty4/supermario:latest"
}

variable "cpu" {
  type    = number
  default = 256
}

variable "memory" {
  type    = number
  default = 1024
}

variable "host_port" {
  type    = number
  default = 8080
}

variable "container_port" {
  type    = number
  default = 8080
}
