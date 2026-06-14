module "infra-module" {
  source         = "./infra-module"
  for_each       = var.tools
  name           = each.key
  instance_type  = each.value["instance_type"]
  policy_name    = each.value["policy_name"]
  key_pair       = var.key_pair
  ports          = each.value["ports"]
  volume_size    = each.value["volume_size"]
}