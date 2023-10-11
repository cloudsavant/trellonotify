# Set variables
$BUCKET_NAME = "trellonotify-source-bucket"
$SOURCE_DIR = ".\app"
$ZIP_NAME = "code.zip"
$TEMP_DIR = ".\temp_deploy"
$CURRENT_DIR = Get-Location

# Create a temporary directory for deployment
if (-not (Test-Path $TEMP_DIR)) {
    New-Item -Path $TEMP_DIR -ItemType Directory
}

# Zip the source code
Write-Host "Zipping source code..."
Set-Location $SOURCE_DIR
Compress-Archive -Path * -DestinationPath "$CURRENT_DIR\$TEMP_DIR\$ZIP_NAME"

# Return to the original directory
Set-Location $CURRENT_DIR

# Upload the zipped file to GCS
Write-Host "Uploading to GCS..."
gsutil cp "$TEMP_DIR\$ZIP_NAME" "gs://$BUCKET_NAME/"

# Clean up the temporary directory
Remove-Item -Recurse -Force $TEMP_DIR

Write-Host "Deployment done!"
