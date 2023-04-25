region = "us-east-1"
access_key = "AKIAXIG4JQIOBT6LIEOT"
secret_key = "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"




vpc_config = {

    "vpc01" = {

        cidr_block = "192.168.0.0/16"

        tags = {

            "Name" = "my_vpc"
        }


    }   

}

subnet_config = {

    "public-us-east-1a" = {
        vpc_name  = "vpc01"
        cidr_block = "192.168.0.0/18"
        availability_zone = "us-east-1a"

        tags = {
            "Name" = "public-us-east-1a"
        }

    }

    "public-us-east-1b" = {
        vpc_name  = "vpc01"
        cidr_block = "192.168.64.0/18"
        availability_zone = "us-east-1b"

        tags = {
            "Name" = "public-us-east-1b"
        }

    }

    "private-us-east-1a" = {
        vpc_name  = "vpc01"
        cidr_block = "192.168.128.0/18"
        availability_zone = "us-east-1a"

        tags = {
            "Name" = "private-us-east-1a"
        }

    }

    "private-us-east-1b" = {
        vpc_name  = "vpc01"
        cidr_block = "192.168.192.0/18"
        availability_zone = "us-east-1b"

        tags = {
            "Name" = "private-us-east-1b"
        }
        

    }

}

internetGW_config = {

    "igw01" = {

        vpc_name = "vpc01"

        tags = {

            Name = "my_IG"

        }

    }


}

elasticIP_config = {

    "epi01" = {
        tags = {
        Name = "nat01"
    }
    }
    "epi02" = {
        tags = {
        Name = "nat02"
    }
    }

}

natGW_config = {

    "natGW01" = {
        epi_name = "epi01"
        subnet_name = "public-us-east-1a"

        tags  = {
            Name = "natGW01"
        }
    }

    "natGW02" = {
        epi_name = "epi02"
        subnet_name = "public-us-east-1b"

        tags = {
            Name = "natWG02"
        }
    }


}


route_table_config = {

   # We  willcreate 2 diffrent private  route table and 1 public #

   "RT01" = {

     private = 0 # to determine the gateway_id we use this resource

     vpc_name = "vpc01"

     gateway_name = "igw01"

     tags = {

        Name = "pubilc-route"
     }




   } 

   "RT02" = {

     private = 1
    
     vpc_name = "vpc01"

     gateway_name = "natGW01"

     tags = {

        Name = "private-route"
     }


   } 

   "RT03" = {

     private = 1

     vpc_name = "vpc01" 

     gateway_name = "natGW02"

     tags = {

        Name = "private-route"
     }

   } 



}

route_table_association_config = {

    RT01Assoc = {
        subnet_name = "public-us-east-1a"
        route_name = "RT01"
    }
    RT02Assoc = {
        subnet_name = "public-us-east-1b"
        route_name = "RT01"
    }
    RT03Assoc = {
        subnet_name = "private-us-east-1b"
        route_name = "RT02"
    }
    RT04Assoc = {
        subnet_name = "private-us-east-1b"
        route_name = "RT03"
    }
}

eks_cluster_config = {

    "cluster01" = {

        eks_cluster_name = "cluster01"

        subnet1 = "public-us-east-1a"
        subnet2 = "public-us-east-1b"
        subnet3 = "private-us-east-1a"
        subnet4 = "private-us-east-1b"

         tags = {
            Name = "cluster01"
         }

    }

   


}

eks_nodegroup_config = {

    "node01" = {

        eks_cluster_name = "cluster01"

        node_group_name = "node01"

        iam_role_node = "eks_node_general_1"

        subnet1 = "private-us-east-1a"
        subnet2 = "private-us-east-1b"

        tags = {
            Name = "node01"
        }


    }

    "node02" = {

        eks_cluster_name = "cluster01"

        node_group_name = "node01"

        iam_role_node = "eks_node_general_1"

        subnet1 = "private-us-east-1a"
        subnet2 = "private-us-east-1b"

        tags = {
            Name = "node02"
        }


    }
}