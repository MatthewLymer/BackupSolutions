# BackupSolutions

## Basic steps

Expose google credentials for terraform
```
export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/legacy_credentials/<your-gcp-email>/adc.json
```

Switch to approperiate terraform version
```
tfswitch
```

Run the terraform commands
```
terraform init
terraform apply
```