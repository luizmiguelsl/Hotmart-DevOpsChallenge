#!/usr/bin/env bash

aws ec2 create-key-pair --key-name hotmart-key --region=us-west-2 | egrep -v "KeyFingerprint|KeyName|KeyPairId|\{|\}" | cut -d "\"" -f4 > key.pem 
