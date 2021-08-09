# random-word-ws-app

This is the code and template for the simple-websocket-chat-app.  There are three functions contained within the directories and a SAM template that wires them up to a DynamoDB table and provides the minimal set of permissions needed to run the app:

```
.
├── README.md                       <-- Instrunctions File
├── fill_words.sh                   <-- Bash Script to populate Words DynamoDB Table
├── src                             <-- Lambda Funcitons Code
│   ├── get-random-word             <-- Get Random Word Lambda Function code
│   ├── on-connect                  <-- On Connect Lambda Function code
│   ├── on-disconnect               <-- On Disconnect Lambda Function code
│   └── update_dependencies.sh      <-- Bash Script to update dependencies
├── template.yml                    <-- SAM YAML Template
└── tf                              <-- Terraform templates
```

- [Deployment](#Deployment)
  - [SAM Deployment](#SAM-Deploymet)
    - [SAM](#SAM)
    - [AWS CLI](#AWS-CLI)
  - [Terraform Deployment](#Terraform-Deploymet)
- [DynamoDB Filler](#DynamoDB-Filler)
- [Test](#Test)
- [License Summary](#License-Summary)


## Deployment

You have two choices for how you can deploy this code.

### SAM Deployment

These app is based on the [simple-websockets-chat-app](https://github.com/aws-samples/simple-websockets-chat-app) an AWS example app.

#### SAM

The first and fastest way is to use AWS's Serverless Application Respository to directly deploy the components of this app into your account without needing to use any additional tools.

If you want to destroy de app you will have to go to the Cloudformation console and delete the created template.

#### AWS CLI

If you prefer, you can install the [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) and use it to package, deploy, and describe your application.  These are the commands you'll need to use:

```bash
sam deploy --guided

aws cloudformation describe-stacks \
    --stack-name {TEMPLATE-NAME} --query 'Stacks[].Outputs' --region {AWS-REGION}
```

If you want to destroy de app you'll need to use:

```bash
aws cloudformation delete-stack \
    --stack-name {TEMPLATE-NAME} --region {AWS-REGION}
```

**Note:** `.gitignore` contains the `samconfig.toml`, hence make sure backup this file, or modify your .gitignore locally.

### Terraform Deployment

Terraform is an alternative to deploy the app. Terraform `v1.0.4` is required to deploy the app .These are the commands you'll need to use:

```bash
# If you want you can override variables values in terraform.tfvars
cd tf
terraform init
terraform apply
```

If you want to destroy de app you'll need to use:

```bash
cd tf
terraform destroy
```

## DynamoDB Filler

You can use the `fill_words.sh` script to populate the `Words` DynamoDB Table. This scrips pulls random words from a [Random Word API](https://random-word-api.herokuapp.com) and uses the `AWS CLI` to push each word to DynamoDB. To use the scrip on the console:

```bash
export AWS_REGION=us-east-2
export TABLE_NAME=words
export NUMBER_OF_WORDS=100
./fill_words.sh
```

## Testing

We will use [wscat](https://github.com/websockets/wscat) as client, these are the required steps:

1. [Install NPM](https://www.npmjs.com/get-npm).
2. Install wscat:
``` bash
$ npm install -g wscat
```
3. On the console, connect to published API endpoint by executing the following command:
``` bash
$ wscat -c wss://{API-ID}.execute-api.{AWS-REGION}.amazonaws.com/{STAGE}
```
4. To test the GetRandomWord function, send a JSON message like the following example. The Lambda function will answer with a random word: 
``` bash
$ wscat -c wss://{API-ID}.execute-api.{AWS-REGION}.amazonaws.com/{STAGE}
connected (press CTRL+C to quit)
> {"action":"getrandomword"}
< {"message":"Your random word is prefinances."}
```

## License Summary

This code is made available under a modified MIT license. See the LICENSE file.
