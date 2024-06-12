resource "random_string" "test" {
  length = 4
  lower  = true
  upper  = false
  special = false
}

resource "databricks_mws_network_connectivity_config" "ncc" {
  provider = databricks.account
  name     = "${prefix}-ncc-${random_string.test.result}"
  region   = local.region
}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [databricks_mws_network_connectivity_config.ncc]
  create_duration = "10s"
}

resource "databricks_mws_ncc_binding" "ncc_binding" {
  provider                       = databricks.account
  network_connectivity_config_id = databricks_mws_network_connectivity_config.ncc.network_connectivity_config_id
  workspace_id                   = local.databricks_workspace_id
  depends_on = [ time_sleep.wait_10_seconds ]
}

resource "databricks_mws_ncc_private_endpoint_rule" "storage" {
  provider                       = databricks.account
  network_connectivity_config_id = databricks_mws_network_connectivity_config.ncc.network_connectivity_config_id
  resource_id                    = var.storage_resource_id
  group_id                       = var.storage_group_id
  depends_on = [ databricks_mws_network_connectivity_config.ncc ]
}