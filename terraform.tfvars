virginia_cidr = "10.10.0.0/16"
subnets = ["10.10.0.0/24", "10.10.1.0/24"]
tags = {
  "env"   = "Development"
  "owner" = "Emmanuel"
  "cloud" = "AWS"
  "proyecto" = "proyecto-prueba"
}

# public_subnet  = "10.10.0.0/24"
# private_subnet = "10.10.1.0/24"

ec2_specs = {
  "ami"           = "ami-04cb4ca688797756f"
  "instance_type" = "t2.micro"
}

sg_ingress_cidr = "0.0.0.0/0"

enable_monitoring = 0

ingress_ports_list = [22, 80, 443]

