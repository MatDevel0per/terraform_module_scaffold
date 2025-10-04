# Mega module scaffold for terraform.

## Testing AWS infrastructure using LocalStack and Terraform Test

This pattern provides a solution to test IaC in Terraform locally without the need to provision infrastructure in AWS. It uses the [Terraform Test framework](https://developer.hashicorp.com/terraform/language/tests) introduced with Terraform version 1.6 and we showcase how to integrate it with LocalStack for Cost Optimization, Speed and Efficiency, Consistency and Reproducibility, Isolation and Safety and Simplified Development Workflow.

Running tests against LocalStack eliminates the need to use actual AWS services, thus avoiding costs associated with creating, modifying, and destroying resources in AWS. Testing locally is significantly faster than deploying resources in AWS.

This rapid feedback loop accelerates development and debugging. Since LocalStack runs locally, you can develop and test your Terraform scripts without an internet connection. LocalStack provides a consistent environment for testing. This consistency ensures that tests yield the same results regardless of external AWS changes or network issues.

Integration with a CI/CD pipeline allows for automated testing of Terraform scripts and modules. This ensures infrastructure code is thoroughly tested before deployment. Testing with LocalStack ensures that you don't accidentally affect live AWS resources or production environments. This isolation makes it safe to experiment and test various configurations. Developers can debug Terraform scripts locally with immediate feedback, streamlining the development process.

You can simulate different AWS regions, accounts, and service configurations to match your production environments more closely.

## Prerequisites

- Docker Installed and configured to enable default Docker socket (/var/run/docker.sock).

- Docker Compose

- AWS Command Line Interface (AWS CLI), [installed](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

- Terraform CLI, [installed](https://developer.hashicorp.com/terraform/cli) (Terraform documentation).

- Terraform AWS Provider, [configured](https://hashicorp.github.io/terraform-provider-aws/) (Terraform documentation).

## Terraform Test

### Run Local Stack Container

In the repository start Local Start Docker execution in detached mode by enter the following command in shell.

```shell
docker compose up -d
```

Wait until the Local Stack container is up and running.

### Terraform Initialization

Enter the following command from the cloned repository to initialize Terraform.

```shell
terraform init
```

### Run Terraform Test

Enter the following command to execute Terraform Test.

```shell
terraform test
```

Verify that all tests successfully passed.

The output should be similar to:

```shell
tests/localstack.tftest.hcl... in progress
  run "check_s3_bucket_name"... pass
  run "check_lambda_function"... pass
  run "check_name_of_filename_written_to_dynamodb"... pass
tests/localstack.tftest.hcl... tearing down
tests/localstack.tftest.hcl... pass

Success! 3 passed, 0 failed.
```

### Resource Cleanup

Enter the following command to destroy Local Stack Container.

```shell
docker compose down
```

## Debugging with AWS CLI

### Run Local Stack Container

In the cloned repository start Local Start Docker execution in detached mode by enter the following command in bash shell.

```shell
docker-compose up -d
```

Wait until the Local Stack container is up and running.

### Authentication

Export the following environment variable to be able to run AWS CLI commands in the local running container that emulates AWS Cloud.

```shell
$AWS_ACCESS_KEY_ID="test"
$AWS_SECRET_ACCESS_KEY="test"
$AWS_SESSION_TOKEN="test"
$AWS_REGION="eu-central-1"
```

### Create Resources Locally

Create resources in the local running container.

```shell
terraform init
terraform plan
terraform apply -auto-approve
```

You can execute AWS CLI commands on the deployed resources

### Destroy the resources

```shell
terraform destroy -auto-approve
```

Enter the following command to destroy Local Stack Container.

```shell
docker compose down
```
