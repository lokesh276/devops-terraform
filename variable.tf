 variable "ec2_instance_type" {
    description = "The type of EC2 instance to create"
    default     = "t2.micro"
   
 }


 variable "ec2_root_storage_size" {
    description = "The size of the root storage volume in GB"
    default     = 13
    type = number
   
 }


 variable "ec2_ami_id" {
    description = "The AMI ID to use for the EC2 instance"
    default     = "ami-0198cdf7458a7a932"  # Amazon Linux 2 AMI (HVM), SSD Volume Type
    type = string
   
 }