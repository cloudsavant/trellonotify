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
gcloud config set project xxxx
gcloud services enable cloudfunctions.googleapis.com
gcloud services enable cloudscheduler.googleapis.com
gcloud services enable storage-api.googleapis.com
gcloud services enable gmail.googleapis.com
gcloud services enable cloudbuild.googleapis.com --project=trellonotify-401705
gcloud services enable cloudscheduler.googleapis.com --project=trellonotify-401705
gcloud services enable cloudresourcemanager.googleapis.com --project=trellonotify-401705
gcloud services enable iam.googleapis.com --project=trellonotify-401705
gcloud services enable secretmanager.googleapis.com --project=trellonotify-401705

'''

## Terraform setup with GCP
### Create Service account
1. In the GCP Console, go to "IAM & Admin" → "Service Accounts".
2. Create a new service account, and download the key as a JSON file.
2.1 For simplicity, we add project/editor role to this account. Later we can narrow it.
2.2 Create new key in JSON format
3. Set an environment variable named GOOGLE_APPLICATION_CREDENTIALS pointing to the path of the downloaded JSON key.
4. remember the email from service account: SERVICE_ACCOUNT_EMAIL
5. run 
'''gcloud projects add-iam-policy-binding trellonotify-401705 --member=serviceAccount:<SERVICE_ACCOUNT_EMAIL> --role=roles/cloudfunctions.admin

gcloud projects add-iam-policy-binding trellonotify-401705 --member=serviceAccount:<SERVICE_ACCOUNT_EMAIL> --role=roles/secretmanager.secretAccessor

gcloud projects add-iam-policy-binding trellonotify-401705 --role roles/secretmanager.secretAccessor --member serviceAccount:trellonotify-401705@appspot.gserviceaccount.com



'''
6. Initialize your Terraform project using terraform init.
7. add secrets to project in power shell
!!!! NOT WORKING, always adding /r/n at the end of the value
'''
# Add new version for TRELLO_LIST_ID
Write-Output "your_trello_list_id_value" -NoNewline | gcloud secrets versions add "TRELLO_LIST_ID" --data-file=-

# Add new version for TRELLO_KEY
Write-Output "your_trello_key_value" -NoNewline | gcloud secrets versions add "TRELLO_KEY" --data-file=-

# Add new version for TRELLO_TOKEN
Write-Output  -NoNewline "your_trello_token_value" | gcloud secrets versions add "TRELLO_TOKEN" --data-file=-
'''

# Application setup
## main.tf modification
- change google project id: xxxxx
- change source bucket name: xxxxx

## deploy.sh modification
- change source BUCKET_NAME: xxxxx

## python env
'''
virtualenv.exe trellonotify
.\trellonotify\Scripts\activate
.\trellonotify\Scripts\Activate.ps1

pip install google-cloud-storage
pip install google-cloud-secret-manager
pip freeze > app/requirements.txt
'''

# Application infrastructure setup
```
terraform -chdir=terraform init
terraform -chdir=terraform apply
```
# Application deployment
```
.\scripts\deploy.ps1
```

# upload data file to cloud
```
gcloud storage cp Z:\contract_monitor_scheduled_task\db.csv gs://trellonotify-files-bucket/db.csv 
```

# TODOs
## Narrow terraform service account roles