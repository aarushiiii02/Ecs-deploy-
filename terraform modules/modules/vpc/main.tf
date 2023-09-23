resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  #rovider = "nikita"
  tags = {
    Name = local.merged_map
  }
}

resource "aws_subnet" "public" {
  count = 2
  cidr_block = "10.0.1${count.index + 1}.0/24"
  vpc_id = aws_vpc.main.id

  tags = {
   Name = local.merged_map
  }
}
resource "aws_security_group" "ecs" {
  name_prefix = "ecs-sg-"

  vpc_id = aws_vpc.main.id
  
  dynamic "ingress" {
    for_each = var.ingrees
    content {
      from_port   = ingress.value
      to_port     = ingress.value 
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
  }
  # data block 
  #if from port to port have different value 
  #port 22 , port http , dynamic block 

  dynamic "egress" {
    for_each = var.egress
    content {
      from_port   = egress.value
      to_port     = egress.value 
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
  }
}



# Define a listener to associate the Target Group with the Load Balancer
#adding a data block to fetch information about the vpc wwe have created

