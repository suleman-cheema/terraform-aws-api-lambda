import json

def lambda_a(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps("Hello, Lambda A!")
    }
