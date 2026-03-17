output "ec2_public_ip" {
    value = aws_instance.my_ec2_instance.public_ip
    description = "The public IP address of the EC2 instance"
}


output "ec2_public_dns" {
    value = aws_instance.my_ec2_instance.public_dns
    description = "The public DNS name of the EC2 instance"
  
}

output "ec2_private_ip" {
    value = aws_instance.my_ec2_instance.private_ip
    description = "The private IP address of the EC2 instance" 
  
}

