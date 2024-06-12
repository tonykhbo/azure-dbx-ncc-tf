variable "databricks_resource_id" {
  description = "The Azure resource ID for the databricks workspace deployment."
}

variable "storage_resource_id" {
    description = "Azure Storage Resoure Resource id"
}

variable "storage_group_id" {
    description = "Azure Storage Type (blob or dfs)"
}

variable "prefix" {
    description = "Any prefix for naming convention such as dev, staging, prod or username"
}


locals {
  resource_regex            = "(?i)subscriptions/(.+)/resourceGroups/(.+)/providers/Microsoft.Databricks/workspaces/(.+)"
  subscription_id           = regex(local.resource_regex, var.databricks_resource_id)[0]
  resource_group            = regex(local.resource_regex, var.databricks_resource_id)[1]
  databricks_workspace_name = regex(local.resource_regex, var.databricks_resource_id)[2]
  databricks_workspace_host = data.azurerm_databricks_workspace.this.workspace_url
  databricks_workspace_id   = data.azurerm_databricks_workspace.this.workspace_id
  region                    = data.azurerm_databricks_workspace.this.location
}

data "azurerm_databricks_workspace" "this" {
  name                = local.databricks_workspace_name
  resource_group_name = local.resource_group
}