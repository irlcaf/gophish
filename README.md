# Automating GOPHISH Setup with Terraform on AWS

This documentation provides a step-by-step guide on automating the setup of a phishing infrastructure using Terraform on AWS. By following these instructions, you can quickly and efficiently deploy your GOPHISH server and associated resources.

## AWS Credentials

Before you begin, you'll need AWS credentials to interact with your AWS account. Here's how to obtain and configure them:

1. **Create AWS Credentials**:
  - Go to the AWS IAM (Identity and Access Management) console.
  - Create access keys for your AWS profile. These keys consist of an `aws_access_key_id` and an `aws_secret_access_key`.


3. **Install AWS CLI**:
  - Install the AWS Command Line Interface (CLI) on your local machine.
  - Configure the AWS CLI by running `aws configure` and providing the credentials you obtained in the previous step.

## Install the Latest Terraform Version

Ensure that you have the latest version of Terraform installed. You can verify this by running the following command:

```
terraform --version
```
3. **Generate SSH Keys**:
  - Open your terminal.
  - Generate SSH keys with the following command:

```
ssh-keygen
```

4. **Configure Terraform**
Now, it's time to configure Terraform for your AWS infrastructure:
**Create an S3 Bucket**:
  - Log in to your AWS Console.
  - Create an S3 bucket in your preferred region. You can use the AWS CLI as well:  
```
aws s3api create-bucket --bucket <bucket-name> --region <your-preferred-region>
```
  - Edit the backend.tfvars file and add the following values:
      bucket: Your S3 bucket name.
      region: The AWS region where you created the bucket.
  - (Optional) If you have set up a different AWS profile name, update it in the main.tf file under the profile variables.


**Initialize Terraform State**

Initialize Terraform state for your infrastructure with the following command:

```
terraform init -backend-config=backend.tfvars
```

**Create Infrastructure**

Now, you're ready to create your infrastructure:
1. Run the following command:

```
terraform apply

```
2. Review the resources Terraform intends to create. Type yes when prompted to proceed. Terraform will now provision your GOPHISH server and associated resources.


## Access GOPHISH Server

After the provisioning is complete, Terraform will provide the GOPHISH server's IP address. You can use this IP address to access your server.

To log in, use the default credentials provided and follow the process to change to a more secure password.
