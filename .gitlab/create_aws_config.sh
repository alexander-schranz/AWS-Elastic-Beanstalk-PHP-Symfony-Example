#!/bin/bash

if [ ! -d ~/.aws ]; then mkdir ~/.aws; fi

cat <<EOT >> ~/.aws/config
[profile eb-cli]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOT
