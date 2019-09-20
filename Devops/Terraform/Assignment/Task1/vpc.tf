# Create VPC/Subnet/Security Group

# create the VPC
resource "aws_vpc" "Muneeb_VPC" {
  cidr_block           = "${var.vpcCIDRblock}"
  instance_tenancy     = "${var.instanceTenancy}" 
  enable_dns_support   = "${var.dnsSupport}" 
  enable_dns_hostnames = "${var.dnsHostNames}"
tags = {
    Name = "Muneeb VPC"
  }
} # end resource


# create the public Subnet 1
resource "aws_subnet" "Muneeb_VPC_Public_Subnet1" {
  vpc_id                  = "${aws_vpc.Muneeb_VPC.id}"
  cidr_block              = "${var.subnetCIDRblockpublic1}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
tags = {
   Name = "Muneeb VPC Public Subnet 1"
  }
} # end resource

resource "aws_subnet" "Muneeb_VPC_Public_Subnet2" {
  vpc_id                  = "${aws_vpc.Muneeb_VPC.id}"
  cidr_block              = "${var.subnetCIDRblockpublic2}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
tags = {
   Name = "Muneeb VPC Public Subnet 2"
  }
} # end resource

resource "aws_subnet" "Muneeb_VPC_Private_Subnet1" {
  vpc_id                  = "${aws_vpc.Muneeb_VPC.id}"
  cidr_block              = "${var.subnetCIDRblockprivate1}"
  availability_zone       = "${var.availabilityZone}"
tags = {
   Name = "Muneeb VPC Private Subnet 1"
  }
} # end resource

resource "aws_subnet" "Muneeb_VPC_Private_Subnet2" {
  vpc_id                  = "${aws_vpc.Muneeb_VPC.id}"
  cidr_block              = "${var.subnetCIDRblockprivate2}"
  availability_zone       = "${var.availabilityZone}"
tags = {
   Name = "Muneeb VPC Private Subnet 2"
  }
} # end resource


# Create the Security Group
resource "aws_security_group" "Muneeb_VPC_Security_Group" {
  vpc_id       = "${aws_vpc.Muneeb_VPC.id}"
  name         = "Muneeb VPC Security Group"
  description  = "Muneeb VPC Security Group"
ingress {
    cidr_blocks = "${var.ingressCIDRblock}"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
tags = {
        Name = "Muneeb VPC Security Group"
  }
} # end resource


# end vpc.tf