# virtual-environment

## create the infrastructure locally

Set your IAM credentials as environment variables to authenticate the Terraform provider
```export AWS_ACCESS_KEY_ID=```
```export AWS_SECRET_ACCESS_KEY=```
```export AWS_SESSION_TOKEN=```

Use the standard actions to create the infrastructure
```terraform init```
```terraform plan```
```terraform apply```

And don't forget to destroy it!
```terraform destroy```

## give GitHub the permission to assume roles

Browse to the ./terraform/iam_oidc_provider module and run terraform
- Create an IAM OpenID Connect provider

