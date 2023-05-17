
resource "aws_network_interface" "fortios_network_interface" {
  for_each = {for k, v in local.fortios_network_interface : k => v if terraform.workspace == local.context.will-prod.workspace_label}

  subnet_id         = each.value.subnet_id
  private_ips       = [each.value.private_ip]
  security_groups   = [aws_security_group.fortios_sg["sg_fgt_cluster"].id]
  source_dest_check = false

  attachment {
    device_index = each.value.index
    instance     = aws_instance.fortios_instance["${each.value.node}"].id
  }

  tags = {
    Name = each.key
    Environment = local.environment
    Management = local.management
    Circle = local.circle
    Product = each.value.tag_product
    Repository = local.repository
  }
}


resource "aws_eip" "fortios_eip" {
  for_each = {for k, v in local.fortios_eip : k => v if terraform.workspace == local.context.will-prod.workspace_label}

  vpc = true
  network_interface = aws_network_interface.fortios_network_interface["${each.value.port_assign}"].id

  tags = {
    Name = each.key
    Environment = local.environment
    Management = local.management
    Circle = local.circle
    Product = each.value.tag_product
    Repository = local.repository
    WhenCreated = each.value.tag_whencreated
  }
}