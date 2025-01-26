import subprocess
import shlex
import os

def handler(event, context):
    credentials_path = os.environ.get('GOOGLE_APPLICATION_CREDENTIALS')
    gcloud_init_cmd = f"cat {credentials_path}"
    subprocess.run(shlex.split(gcloud_init_cmd), check=True)
    # gcloud_init_cmd = "gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"

    cbt_import_cmd = "cbt import test123 test.csv column-family=info batch-size=50000 workers=10 timestamp=now"
    subprocess.run(shlex.split(cbt_import_cmd), check=True)
    return {
        'statusCode': 200,
        'body': 'Hello World!'
    }