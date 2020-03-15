#!/bin/sh
echo "creating archive"
NOW=$(date +"%Y-%m-%d_%H-%M-%S")
tar -zcvf "/tmp/${BACKUP_NAME}-${NOW}.tar.gz" /data
echo "uploading archive to S3"
[[ -n "$AWS_ENDPOINT_URL" ]] && AWS_ENDPOINT_OPT="--endpoint-url $AWS_ENDPOINT_URL"
aws ${AWS_ENDPOINT_OPT} s3 cp /tmp/*.tar.gz $S3_BUCKET_URL
echo "removing local archive"
rm /tmp/*.tar.gz
echo "done"
