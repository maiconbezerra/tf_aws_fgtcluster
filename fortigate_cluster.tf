
resource "aws_instance" "fortios_instance" {
  for_each = {for k, v in local.fortios_instance : k => v if terraform.workspace == local.context.will-prod.workspace_label}

  ami = each.value.ami
  instance_type = each.value.instance_type
  disable_api_termination = each.value.disable_api_termination
  disable_api_stop = each.value.disable_api_stop
  availability_zone = each.value.az
  subnet_id = each.value.subnet_id
  private_ip = each.value.primary_ip
  vpc_security_group_ids = [aws_security_group.fortios_sg["sg_fgt_cluster"].id]
  key_name = each.value.key_name
  iam_instance_profile = aws_iam_role.fortios_iam_role["rol-fgt-cluster"].name
  source_dest_check = each.value.source_dest_check

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
