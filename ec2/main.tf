provider "aws" {
    region = "ap-southeast-1"
  
}

resource "aws_instance" "myec2" {
    ami = "ami-0b7e55206a0a22afc"
    instance_type = "t2.micro" 
}



resource "aws_vpc" "my_vpc" {
     cidr_block = "54.0.0.0/16"
  tags = {
    Name = "tf-example-vpc"
  }
}


resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "54.0.10.0/24"
  availability_zone = "ap-southeast-1a"


tags = {
    Name = "tf-example-subnet"
  }
}
resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["54.0.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "foo" {
  ami           = "ami-0b7e55206a0a22afc" # ap-southeast-1
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}