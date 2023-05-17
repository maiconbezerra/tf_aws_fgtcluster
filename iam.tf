
resource "aws_iam_policy" "fortios_iam_policy" {
  for_each = {for k, v in local.fortios_iam_policy : k => v if terraform.workspace == local.context.will-prod.workspace_label}

  name        = each.key
  description = each.value.description
  policy = each.value.policy

  tags = {
    Name = each.key
    Environment = local.environment
    Management = local.management
    Circle = local.circle
    Product = each.value.tag_product
    Repository = local.repository
  }
}


resource "aws_iam_role" "fortios_iam_role" {
  for_each = {for k, v in local.fortios_iam_role : k => v if terraform.workspace == local.context.will-prod.workspace_label}

  name        = each.key
  description = each.value.description
  assume_role_policy = each.value.assume_role_policy

  tags = {
    Name = each.key
    Environment = local.environment
    Management = local.management
    Circle = local.circle
    Product = each.value.tag_product
    Repository = local.repository
  }
}


resource "aws_iam_role_policy_attachment" "fortios_iam_role_attach" {
  for_each = {for k, v in local.fortios_iam_role_attach : k => v if terraform.workspace == local.context.will-prod.workspace_label}

  role       = aws_iam_role.fortios_iam_role["${each.value.role}"].name
  policy_arn = aws_iam_policy.fortios_iam_policy["${each.value.policy}"].arn
}
