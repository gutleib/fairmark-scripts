#! /bin/bash
#ну ооочень черновик
api_url='https://int01.gismt.crpt.tech/api/v3/true-api'
echo''
token=$(./get-last-token.sh)
#echo 
curl -s -X  GET ''$api_url'/cises/listV2?pg=milk&limit=1000&cisStatus=APPLIED' -H 'Authorization: Bearer '$token''
#?cache=string&cis=string&cisAggregationState=string&cisPackageType=string&cisStatus=string
