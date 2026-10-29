
import json

def handler(event, context):
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "message": "LMS-2026 API funcionando",
            "environment": "dev"
        })
    }
