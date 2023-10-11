# Trellonotify
A lightweight tool designed to seamlessly integrate with Trello, automatically generating Trello cards for upcoming tasks and events. Say goodbye to forgotten tasks and missed deadlines, and let Trellonotify keep your Trello boards up-to-date with timely reminders.
This tool was originally developed for local/NAS based usage. Now it will be migrated to cloud. 

# Requirements
1. GCP account

# Setup
## Terraform setup on windows
- Download terraform.exe
- add to windows path

## GCP Project setup
'''
gcloud auth login
gcloud config set project trellonotify-401705
'''

## Terraform setup with GCP
### Create Service account
1. In the GCP Console, go to "IAM & Admin" → "Service Accounts".
2. Create a new service account, and download the key as a JSON file.
2.1 For simplicity, we add project/editor role to this account. Later we can narrow it.
2.2 Create new key in JSON format
3. Set an environment variable named GOOGLE_APPLICATION_CREDENTIALS pointing to the path of the downloaded JSON key.
4. Initialize your Terraform project using terraform init.

# TODOs
## Narrow terraform service account roles