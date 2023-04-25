resource "aws_nat_gateway" "example" {
  allocation_id = var.elasticIP-id
  subnet_id     = var.subnet_id

  tags =  var.tags
}


# for nat-gateway we need Elastic IP f.t we use allocation id #