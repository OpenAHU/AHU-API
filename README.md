# AHU-API

## Above All

Basiclly, it's a playground for IaC, Serverless, Cloud Native, DevOps, CI/CD, etc.

Then, it's the backend infrastructure for OpenAHU's projects

IaC: 

https://spacelift.io/blog/infrastructure-as-code

More: 

- https://spacelift.io/blog
- https://developer.hashicorp.com/terraform/docs
- https://terragrunt.gruntwork.io/docs/

## On Board

```bash
npm install -g esbuild

cd terraform

terraform init
```

## Development

### Node

https://cloud.tencent.com/document/product/583/67790

Sync:

```js
export const handler = (event, context, callback) => {
  // first argument is error, second is response
  callback(null, {
    statusCode: 200,
    body: JSON.stringify({
      message: "Hello World",
    }),
  });
};
```

Async:

```js
export const handler = async (event, context) => {
  return new Promise((resolve, reject) => {
    resolve({
      statusCode: 200,
      body: JSON.stringify({
        message: "Hello World",
      }),
    });
    // error by throw instead of reject
    // throw new Error("Something went wrong");
  }); 
};
```

## Deploy

go to `terraform/`

create `terraform/variables.tfvars`, add host and domain inside

run `terraform apply -var-file=variables.tfvars`

## QA

Error: the domain name is not configured with CNAME to the default domain name, or the resolution is not effective.

> wait for 10 minutes, then try again, cause the domain name resolution takes time
