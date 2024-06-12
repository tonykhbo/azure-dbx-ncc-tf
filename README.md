## NCC Example for Azure Databricks

This is a simple terraform example of creating the following in the Databricks Account Console:
- Network Connectivity Config
- NCC Private Endpoint for Storage
- NCC Workspace Binding

#### Prerequisites
- Databricks Account Admin Access
- Must run ```az login``` from the cli and authenticate into your azure account
- Permission to create the NCC Object
- Copy the ```env.tfvars.example``` file into a ```env.tfvars``` and make the appropriate changes to the following variables
    - ```databricks_resource_id```
    - ```prefix```
    - ```storage_resource_id```
    - ```storage_group_id```

#### Instructions
1. Run ```terraform init```
2. To see the terraform plan, run the following ```terraform plan -var-file="env.tfvars"```
3. To create the resources, run the following ```terraform apply -var-file="env.tfvars"```
4. To delete and clean up your resources created in step 3, run ```terraform destroy -var-file="env.tfvars"```