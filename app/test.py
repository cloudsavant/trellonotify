import logging

def hello_gcp(request):
    """ Cloud Function to be triggered by HTTP.
    Args:
        request (flask.Request): The request object.
        <http://flask.pocoo.org/docs/1.0/api/#flask.Request>
    Returns:
        str: The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>.
    """
    logging.info('Hello in GCP')
    return 'Logged "Hello in GCP"!', 200

if __name__ == "__main__":
    # This block is for local testing and will not be executed in GCP environment
    hello_gcp(None)
