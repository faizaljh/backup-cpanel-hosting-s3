#!/bin/bash

username=$(whoami)
path="./"

## Insert S3 Credentials
S3PROTOCOL="http"
S3ENDPOIN="global.jagoanstorage.com"
S3KEY="******"
S3SECRET="*****"
bucket="****"

## S3 Config Path & Bucket
dream_path="/${username}/$(date +%F)/"

function BackupToS3 {

  path="$1"
  file="$2"
  S3_path="$3"
  bucket="$4"

  full_path="${bucket}${S3_path}${file}"
  date=`date -R -u`

  content_type='application/x-compressed-tar'
  string="PUT\n\n${content_type}\n${date}\n/${full_path}"
  signature=$(echo -en "${string}" | openssl sha1 -hmac "${S3SECRET}" -binary | base64)

  curl -X PUT -T "${path}/${file}" \
    -H "Host: ${bucket}.${S3ENDPOIN}" \
    -H "Date: ${date}" \
    -H "Content-Type: ${content_type}" \
    -H "Authorization: AWS ${S3KEY}:${signature}" \
    "${S3PROTOCOL}://${bucket}.${S3ENDPOIN}${S3_path}${file}"
}

# Create Backup using Cpanel UAPI
uapi Backup fullbackup_to_homedir

while [ -z "$file" ]
do
  sleep 2 # or less like 0.2
  file=$(ls | grep ${username}.tar.gz | tail -n 1)
  file_temp=$( basename "${HOME}/${file}" .tar.gz)
  check=$(ls | grep -E "${file_temp}$")
  if [ ! -z "$check" ]
  then
    file=""
    echo "Waiting For Backup"
  fi
done

BackupToS3 "${path}" "${file}" "${dream_path}" "${bucket}"
cd $HOME
rm -f ${file}
