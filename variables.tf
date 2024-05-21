variable "ssh_pub_key" {
  # Get your own public key from ~/.ssh/your_key.pub
  description = "The public key to use for SSH access"
  type        = string
}

variable "ssh_key_name" {
  # Set your own key name
  description = "The name of the SSH key pair to use"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "Allow ssh all inbound"
}

variable "bucket_name" {
  # Choose your own bucket name (must be globally unique)
  description = "Name of the S3 bucket"
  type        = string
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t4g.nano"
}

variable "environment" {
  description = "Environment tag for resources"
  type        = string
  default     = "dev"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "test-instance"
}
