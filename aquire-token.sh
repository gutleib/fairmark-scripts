#! /bin/bash
api_url='https://int01.gismt.crpt.tech/api/v3/true-api'
echo''
echo 'This script will generate a token for automated interaction with '$api_url
echo ''
echo 'List of certificates in system (available through CryptoPro)'
certmgr -list
echo ''
read -p "Enter fingerprint (SHA-1) of a certificate to use for auth > " cert_finger
#read -p "Enter password for a certificate use > " cert_password
echo'' 
echo ''
echo ''
session_id="session-$(date +%y-%m-%d_%R)" 
echo "$session_id" 
mkdir ./$session_id 
curl --silent --location --request GET $api_url/auth/key > ./$session_id/session.tmp 
uuid=$(cat ./$session_id/session.tmp | grep -o '".*"' | sed 's/"/\n/g'|sed -n '4p') 
cat ./$session_id/session.tmp | grep -o '".*"' | sed 's/"/\n/g'|sed -n '8p'|tr -d '\n'> ./$session_id/data
#echo $cert_finger
#/opt/cprocsp/bin/amd64/csptest -sfsign -sign -in ./$session_id/data -out ./$session_id/data-no64.sig -add -my $cert_finger 
echo ''
echo ''
echo ''
/opt/cprocsp/bin/amd64/csptest -sfsign -sign -in ./$session_id/data -out ./$session_id/data.sig -add -base64 -my $cert_finger 
# -password $cert_password
cat ./$session_id/data.sig|tr -d '\n' |tr -d '$' > ./$session_id/data_oneline.sig
signed_data=$(cat ./$session_id/data_oneline.sig)
echo ''
#echo curl --location --request POST "'"$api_url"/auth/simpleSignIn'" --header "'Content-Type: application/json;charset=UTF-8'" --header "'cache-control: no-cache'" --data-raw "'{" '"uuid"': '"'"$uuid"'"', '"data"': '"'""'"' }"'" > ./$session_id/empty_request
echo curl --location --request POST "'"$api_url"/auth/simpleSignIn'" --header "'Content-Type: application/json;charset=UTF-8'" --header "'cache-control: no-cache'" --data-raw "'{" '"uuid"': '"'"$uuid"'"', '"data"': '"'"$signed_data"'"' }"'" > ./$session_id/request
curl --silent --location --request POST ''$api_url'/auth/simpleSignIn' --header 'Content-Type: application/json;charset=UTF-8' --header 'cache-control: no-cache' --data-raw ' { "uuid": "'$uuid'", "data": "'$signed_data'" }' > ./$session_id/response
echo ''
echo ''
echo ''
echo 'Token aquired successfuly:'
echo ''
cat ./$session_id/response |cut -d '"' -f4|tr -d '\n'| tee $session_id-token
echo ''
echo ''
echo ''
