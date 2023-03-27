variable "vpc-cidr" {
    default = "10.0.0.0/16"
    description = "vpc cidr block"
    type = string
}

variable "public-subnet-1-cidr" {
    default = "10.0.0.0/24"
    description = "public subnet 1"
    type = string
}

variable "public-subnet-2-cidr" {
    default = "10.0.1.0/24"
    description = "public subnet 2"
    type = string
}

variable "private-subnet-3-cidr" {
    default = "10.0.3.0/24"
    description = "private subnet 3"
    type = string
}

variable "private-subnet-4-cidr" {
    default = "10.0.4.0/24"
    description = "private subnet 4"
    type = string
}
variable "skip_final_snapshot" {
  type        = bool
  default = "true"
}
variable "rds_cluster_identifier" {
  type        = string
  default = "example-cluster"
}
variable "engine" {
    type = string
    default = "aurora-mysql"
}
variable "engine_mode" {
    type = string
    default = "provisioned"
}
variable "engine_version" {
    type = string
    default = "5.7.mysql_aurora.2.11.2"
}
variable "master_username" {
    type = string
    default = "admin"
}
variable "master_password" {
    type = string
    default = "exampledbcluster"
}
variable "database_name" { 
    type = string
    default = "exampledb"
}
variable "port" {
    type = number
    default = 3306
}
variable "iam_database_authentication_enabled" {
    type = bool
    default = true
}
variable "deletion_protection" {
    type = bool
    default = false
}
variable "instance_class" {
    type = string
    default = "db.t4g.medium"
}
variable "publicly_accessible" {
    type = bool
    default = false
}

