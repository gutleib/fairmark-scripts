#! /bin/bash
api_url='https://int01.gismt.crpt.tech/api/v3/true-api'
echo''
echo 'This script will make an anonymous request to '$api_url' to check if it answers...'
echo''
curl --silent $api_url/participants/7731376812 |grep true > /dev/null 
#2>&1
if [ $? -eq 0 ]
then
  echo "Success: TrueAPI is alive."
  exit 0
else
  echo "Failure: TrueAPI is not answering" >&2
  exit 1
fi
