#key pair

resource "aws_key_pair" "my_key_pair" {
    key_name   = "terra-key"
    public_key = file("terra-key.pub")
  
}
#VPC and Security Group

resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "my_security_group" {
  
   name = "automated_security_group"
   description = "Security group for automated EC2 instance"
   vpc_id = aws_default_vpc.default.id  #interpolating the default vpc id


# inbound rule to allow SSH access

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # allowing SSH access from anywhere (not recommended for production)
        description = "Allow SSH access"
    }   

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  # allowing HTTP access from anywhere
        description = "Allow HTTP access"
    }


    #  ingress {
    #     from_port = 8000
    #     to_port = 8000
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]  # allowing access to port 8000 from anywhere\
    #     description = "Flask app access"
    #  }

# allowing all outbound traffic

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"  # -1 means all protocols
        cidr_blocks = ["0.0.0.0/0"] 
        description = "Allow all outbound traffic"        
    }
    tags = {
        Name = "automated_security_group"
    }

   }



#ex2 instance


resource "aws_instance" "my_ec2_instance" {
    ami           = var.ec2_ami_id
    user_data     = file("install_nginx.sh")
    instance_type = var.ec2_instance_type
    key_name      = aws_key_pair.my_key_pair.key_name

    # ✅ Use ID-based reference, not name
    vpc_security_group_ids = [aws_security_group.my_security_group.id]

    tags = {
        Name = "Automated EC2 Instance"
    }

    root_block_device {
        volume_size = var.ec2_root_storage_size
        volume_type = "gp3"
    }
}


          