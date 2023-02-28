import os


authed_xhs = os.environ["AUTHED_XHS"].split(",")

def handler(event, context):
    xh = event["queryString"]["xh"]
    if xh in authed_xhs:
        return {
            "statusCode": 200,
            "body": "authed"
        }
    else:
        return {
            "statusCode": 401,
            "body": "unauthed"
        }
