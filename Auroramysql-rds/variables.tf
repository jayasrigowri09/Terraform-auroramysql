
# variable "region" {
#   type    = string
#   default = "us-east-1"
# }
# variable "vpc-cidr" {
#   default     = "10.0.0.0/16"
#   description = "vpc cidr block"
#   type        = string
# }
# variable "count" {
#   default     = "3"
#   description = "create 3 read replicas"
#   type        = number
# }

# variable "public-subnet-1-cidr" {
#   default     = "10.0.0.0/24"
#   description = "public subnet 1"
#   type        = string
# }

# variable "public-subnet-2-cidr" {
#   default     = "10.0.1.0/24"
#   description = "public subnet 2"
#   type        = string
# }
# variable "db_instance_count" {
#   default = 2
# }

# variable "private-subnet-3-cidr" {
#   default     = "10.0.3.0/24"
#   description = "private subnet 3"
#   type        = string
# }

# variable "private-subnet-4-cidr" {
#   default     = "10.0.4.0/24"
#   description = "private subnet 4"
#   type        = string
# }


variable "skip_final_snapshot" {
  description = "If true no snapshot is created"
  type        = bool
  default     = "true"
}
variable "cluster_identifier" {
  description = "Name of the Db cluster"
  type        = string
  default     = "example-cluster"
}
variable "replica_enabled" {
  description = "whether to enable autoscaling for Rds Aurora read replicas"
  type        = string
  default     = false
}
variable "replica_count" {
  description = "If replica_enabled is true, it will create read replica, or else it will create writer instance"
  type        = string
  default     = "1"
}
variable "engine" {
  description = "The name of the engine to be used for the DB cluster"
  type        = string
  default     = "aurora-mysql"
}
variable "engine_mode" {
  description = "The DB engine_mode. Valid values are, provisioned, serverless"
  type        = string
  default     = "provisioned"
  validation {
    condition     = contains(["provisioned"], var.engine_mode)
    error_message = "engine_mode should be 'provisioned' only"
  }
}
variable "engine_version" {
  description = "DB engine version"
  type        = string
  default     = "5.7.mysql_aurora.2.11.2"
}
variable "master_username" {
  description = "username for the master DB user"
  type        = string
  default     = "admin"
}
variable "master_password" {
  type    = string
  default = "auroradbcluster"
}
variable "database_name" {
  type    = string
  default = "aurorab"
}
variable "port" {
  type    = number
  default = 3306
}
variable "iam_database_authentication_enabled" {
  description = "Whether to enable IAM db authentication for the RDS Cluster"
  type        = bool
  default     = true
}
variable "deletion_protection" {
  description = "specifies the db instance should have deletion protection enabled"
  type        = bool
  default     = false
}
variable "instance_class" {
  description = "Instance type to use"
  type        = string
  default     = "db.t4g.medium"
}
variable "publicly_accessible" {
  description = "If saet to no, not exposed to the internet"
  type        = bool
  default     = false
}

