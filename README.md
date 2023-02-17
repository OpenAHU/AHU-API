# AHU-API

## On Board

```
npm install -g esbuild

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
