terraform init -reconfigure -backend-config ..\backend-dt.conf

terraform plan -var-file .\prod.tfvars

terraform apply -var-file .\prod.tfvars --auto-approve