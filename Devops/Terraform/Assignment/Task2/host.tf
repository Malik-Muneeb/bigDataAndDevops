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

egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }

tags = {
        Name = "Muneeb VPC Security Group"
  }
} # end resource


# end vpc.tf


resource "aws_instance" "Muneeb_Bastian_Host" {
  ami           = "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.Muneeb_VPC_Security_Group.id}"]
  subnet_id = "${aws_subnet.Muneeb_VPC_Public_Subnet1.id}"
  key_name = "MuneebKeyPair"
  associate_public_ip_address = true
  tags = {
    Name = "Muneeb Bastian Host"
  }
}


resource "aws_instance" "Muneeb_Private_instance" {
  ami           = "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
  key_name = "MuneebKeyPair"
  security_groups = ["${aws_security_group.Muneeb_Security_Group_Private.id}"]
  subnet_id = "${aws_subnet.Muneeb_VPC_Private_Subnet1.id}"
  tags = {
    Name = "Muneeb Private Instance"
  }
}

# Create the Security Group
resource "aws_security_group" "Muneeb_Security_Group_Private" {
  vpc_id       = "${aws_vpc.Muneeb_VPC.id}"
  name         = "Muneeb Security Group Private"
  description  = "Muneeb Security Group Private"

ingress {
    cidr_blocks = ["10.0.1.0/24"]  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

tags = {
        Name = "Muneeb Security Group For Private Instance"
  }
} # end resource

# Create the Internet Gateway
resource "aws_internet_gateway" "Muneeb_VPC_GW" {
  vpc_id = "${aws_vpc.Muneeb_VPC.id}"
tags = {
        Name = "Muneeb VPC Internet Gateway"
    }
} # end resource


# Create the Route Table
resource "aws_route_table" "Muneeb_VPC_route_table" {
    vpc_id = "${aws_vpc.Muneeb_VPC.id}"
tags = {
        Name = "Muneeb VPC Route Table"
    }
} # end resource

# Create the Internet Access
resource "aws_route" "Muneeb_VPC_internet_access" {
  route_table_id        = "${aws_route_table.Muneeb_VPC_route_table.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  gateway_id             = "${aws_internet_gateway.Muneeb_VPC_GW.id}"
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "Muneeb_VPC_association" {
    subnet_id      = "${aws_subnet.Muneeb_VPC_Public_Subnet1.id}"
    route_table_id = "${aws_route_table.Muneeb_VPC_route_table.id}"
} # end resource