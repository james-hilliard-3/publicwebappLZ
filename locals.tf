
locals {
  prod_rg_name  = "${var.resource_prefix}-prod-rg"
  qa_rg_name    = "${var.resource_prefix}-qa-rg"
  test_rg_name  = "${var.resource_prefix}-test-rg"
  prod_vnet_name = "${var.resource_prefix}-prod-vnet"
  qa_vnet_name = "${var.resource_prefix}-qa-vnet"
  test_vnet_name = "${var.resource_prefix}-test-vnet"
}
