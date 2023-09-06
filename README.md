# gophish-terraform
Terraform automation for phishing infrastructure.

## AWS Credentials
Go to to IAM center and create credentials for your profile, specifically: 
```
aws_access_key_id = AKIA*****************
aws_secret_access_key= ******************
```

Install aws cli on your host and configure the credentials:
```
aws configure
```

## Install latest terraform version
Check with terraform --version, output should be something similar to Terraform v1.5.4

## Create your ssh keys
```
ssh-keygen
```

Input the name of your key file and go to gophish/variables.tf and change the default (id_rsa.pub) for the name that you gave your ssh key.

## Setting terraform configuration
Go to your aws console and create an s3 bucket on your prefered region.
Through aws cli you can just do 
```
aws s3api create-bucket --bucket <bucket-name> --region <your-preferred-region>
```
Navigate to backend.tfvars and add to the bucket variable your bucket name, region variable the region where you created the bucket.
(Optional) If you have setup a different profile name for your change it at main.tf under profile variables.

Now initialize terraform state for your infrastructure with the following command:
```
terraform init -backend-config=backend.tfvars
```

This will initialize your terraform state on an S3 bucket in your aws account.

Now, create your terraform infrastructure.

```
terraform apply
```

Check that the resources you want to create are correct and type yes when prompted.
Terraform will output your gophish server ip address.

To login, use default credentials and follow the process to change to a more secure password.