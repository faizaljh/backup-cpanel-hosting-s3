# jagoanhosting-backup-cpanel-hosting-s3
You can use this script to backup your cpanel hosting (Full Backup) to Object Storage

#### Basic Flow:
1. Doing Full Backup on Cpanel using UAPI
2. Waiting for Full Backup Done
3. Upload to S3

#### Main Config
```shell script
S3KEY="******"
S3SECRET="*****"
bucket="****"
```

Get Your Credential S3 and create bucket to store your backup

if your backup not locate on user folder, you can change
```shell script
path="./"
```

#### Installation
1. Upload **s3-backup.sh** to /home/{user}
2. Setup Config
3. Create Cron Job, your can set as you like. (daily, monthly, ETC). Every cron execute backup will process backup to S3
```shell script

```

#### How to get S3 Storage
You can get S3 Storage here: 

[S3 Object Storage](https://www.jagoanhosting.com/cloud-object-storage/?utm_source=github&utm_medium=readme&utm_campaign=BackupS3&utm_id=BackupS3)
with only 0.75 USD with unlimited data transfer
