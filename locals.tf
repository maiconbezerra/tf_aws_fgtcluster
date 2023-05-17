
locals {
  #  IAM Policy config
  fortios_iam_policy = {

    pol-fgt-cluster = {
      description = "Policy que permite a utilizacao do vip por ambos nodes."
      policy = file("./iam_policy/pol-fgt-cluster.json")
      tag_product = "IAM"
    }

  }


  #  IAM Role config
  fortios_iam_role = {

    rol-fgt-cluster = {
      description = "Allows EC2 instances to call AWS services on your behalf."
      assume_role_policy = file("./iam_role/rol-fgt-cluster.json")
      tag_product = "IAM"
    }

  }


  #  IAM Role Attachment config
  fortios_iam_role_attach = {

    rol-fgt-cluster_attach-001 = {
      role = "rol-fgt-cluster"
      policy = "pol-fgt-cluster"
    }

  }


  #  Security Group Config
  fortios_sg = {

    sg_fgt_cluster = {
      description = "Fortigate Cluster config",
      vpc_id = "vpc-0d1c68d3bc6a4cce7",
      tag_product = "Security Group"
    }

  }


  #  Security Group Rule Config
  fortios_sg_rules = {
    #  Ingress Rules Entries
    ingress_001 = {
      security_group   = "sg_fgt_cluster"
      type             = "ingress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
    }
    ingress_002 = {
      security_group   = "sg_fgt_cluster"
      type             = "ingress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = null
      ipv6_cidr_blocks = ["::/0"]
    }

    #  Egress Rules Entries
    egress_001 = {
      security_group   = "sg_fgt_cluster"
      type             = "egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
    }
    egress_002 = {
      security_group   = "sg_fgt_cluster"
      type             = "egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = null
      ipv6_cidr_blocks = ["::/0"]
    }
  }


  #  Network interfaces Config
  fortios_network_interface = {
    #  Network Interfaces Node -> aws-saeast1a-vfw01
    vfw01_port2 = {index = 1, private_ip = "10.210.2.50", subnet_id = "subnet-08e2d94fdc44340c4", sg = "sg_fgt_cluster", node = "aws-saeast1a-vfw01", tag_product = "Network Interface"}
    vfw01_port3 = {index = 2, private_ip = "10.210.3.50", subnet_id = "subnet-088859cc63fecee86", sg = "sg_fgt_cluster", node = "aws-saeast1a-vfw01", tag_product = "Network Interface"}
    vfw01_port4 = {index = 3, private_ip = "10.210.4.50", subnet_id = "subnet-075f3cd5b3a38460d", sg = "sg_fgt_cluster", node = "aws-saeast1a-vfw01", tag_product = "Network Interface"}

    #  Network Interfaces Node -> aws-saeast1b-vfw02
    vfw02_port2 = {index = 1, private_ip = "10.210.12.50", subnet_id = "subnet-01733922939ac5e5e", sg = "sg_fgt_cluster", node = "aws-saeast1b-vfw02", tag_product = "Network Interface"}
    vfw02_port3 = {index = 2, private_ip = "10.210.13.50", subnet_id = "subnet-025d5e9a7cb553513", sg = "sg_fgt_cluster", node = "aws-saeast1b-vfw02", tag_product = "Network Interface"}
    vfw02_port4 = {index = 3, private_ip = "10.210.14.50", subnet_id = "subnet-0b2e53ac7a764d096", sg = "sg_fgt_cluster", node = "aws-saeast1b-vfw02", tag_product = "Network Interface"}
  }


  #  Instances Config
  fortios_instance = {

    aws-saeast1a-vfw01 = {
        ami = "ami-0ad0eb946b258b7b7",
        instance_type = "c6i.xlarge",
        az = "sa-east-1a",
        subnet_id = "subnet-01b37227a82531b84",
        primary_ip = "10.210.1.50",
        disable_api_termination = true,
        disable_api_stop = true,
        source_dest_check = false,
        tag_whencreated = "20230412",
        tag_product = "Firewall - Fortigate",
        key_name = "key-networking_ssh"
    },

    aws-saeast1b-vfw02 = {
      ami = "ami-068daf5e38aed7986",
      instance_type = "c6i.xlarge",
      az = "sa-east-1b",
      subnet_id = "subnet-0f60606b671c3bb0e",
      primary_ip = "10.210.11.50",
      disable_api_termination = true,
      disable_api_stop = true,
      source_dest_check = false,
      tag_whencreated = "20230316",
      tag_product = "Firewall - Fortigate",
      key_name = "key-networking_ssh"
    },
  }

  #  Elastic IP Assignment Config
  fortios_eip = {
    # EIP assignment to aws-saeast1a-vfw01 port 4
    eip_mgmt_vfw01 = {port_assign = "vfw01_port4", tag_whencreated = "20230316", tag_product = "Elastic IP"}
    # EIP assignment to aws-saeast1b-vfw02 port 4
    eip_mgmt_vfw02 = {port_assign = "vfw02_port4", tag_whencreated = "20230316", tag_product = "Elastic IP"}

  }

}
