# we'll attached this elastic IP to the natGW

resource "aws_eip" "nat" {
     tags = var.tags
}



