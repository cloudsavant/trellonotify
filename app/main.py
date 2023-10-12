import logging
from google.cloud import secretmanager
import os

def get_secret(secret_id, version_id="latest"):
    client = secretmanager.SecretManagerServiceClient()
    # Build the resource name of the secret version.
    name = f"projects/trellonotify-401705/secrets/{secret_id}/versions/{version_id}"

    # Access the secret version.
    response = client.access_secret_version(name=name)
    print(f'response={response}')
    # Return the decoded payload.
    return response.payload.data.decode('UTF-8')

def test_function(request):
    """ Cloud Function to be triggered by HTTP.
    Args:
        request (flask.Request): The request object.
        <http://flask.pocoo.org/docs/1.0/api/#flask.Request>
    Returns:
        str: The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>.
    """
    logging.info('Hello in GCP nnnnnnn')
    resp = get_secret('TRELLO_LIST_ID')
    print(f'resp={resp}')
    logging.info(f'resp={resp}')
    return 'Logged "Hello in GCP"!', 200


if __name__ == "__main__":
    # This block is for local testing and will not be executed in GCP environment
    print('main called')
    test_function(None)