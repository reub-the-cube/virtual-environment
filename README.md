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

### ./iam_oidc_provider

Create a long-lived OIDC provider for the GitHub action.
Gives a tag to protect from aws-nuke.
There is only a maximum of 1 identity provider for any given Provider URL, but multiple roles will be able to use it as a Principal.

### ./iam_role_github_action
Browse to the ./terraform/iam_role_github_action module.
Create a .auto.tfvars file to specify variables used in the terraform.
Applying the terraform will:
- Lookup the IAM OpenID Connect provider for GitHub actions
- Create a role that allows an OIDC relationship between a specific repository and AWS
- Load a specified policy and apply it to the role