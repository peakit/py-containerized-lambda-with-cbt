import subprocess
import shlex

def handler(event, context):
    gcloud_init_cmd = "gcloud auth activate-service-account --key-file=${GOOGLE_APPLICATION_CREDENTIALS}"
    cbt_import_cmd = "cbt import test123 test.csv column-family=info batch-size=50000 workers=10 timestamp=now"
    subprocess.run(shlex.split(gcloud_init_cmd), check=True)
    subprocess.run(shlex.split(cbt_import_cmd), check=True)
    return {
        'statusCode': 200,
        'body': 'Hello World!'
    }