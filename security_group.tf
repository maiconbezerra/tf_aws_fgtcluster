
#  Manages Security Groups
resource "aws_security_group" "fortios_sg" {
  for_each = {for k, v in local.fortios_sg : k => v if terraform.workspace == local.context.will-prod.workspace_label}

  name = each.key
  description = each.value.description
  vpc_id = each.value.vpc_id

  tags = {
    Name = each.key
    Circle = local.circle
    Environment = local.environment
    Management = local.management
    Product = each.value.tag_product
    Repository = local.repository
  }
}


#  Manages Security Group Rules
resource "aws_security_group_rule" "fortios_sg_rule" {
  for_each = {for k, v in local.fortios_sg_rules : k => v if terraform.workspace == local.context.will-prod.workspace_label}

  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks = each.value.cidr_blocks
  ipv6_cidr_blocks = each.value.ipv6_cidr_blocks
  security_group_id = aws_security_group.fortios_sg["${each.value.security_group}"].id
}