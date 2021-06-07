#! /bin/bash
#ну ооочень черновик
api_url='https://int01.gismt.crpt.tech/api/v3/true-api'
goods_category=milk
#TrueAPI has following categories of goods (pg) tracked:
# lp Предметы одежды
# shoes Обувные товары
# tobacco Табачная продукция
# perfumery Духи и туалетная вода
# tires Шины и покрышки
# electronics Фотокамеры (кроме кинокамер)
# milk Молочная продукция
# bicycle Велосипеды и велосипедные рамы
# wheelchairs Кресла-коляски
# otp Альтернативная табачная продукция
# water Упакованная вода
# furs Товары из натурального меха
# beer Пиво, слабоалкогольные напитки
# ncp Никотиносодержащая продукция
# bio Биологические активные добавки кпище
echo''
token=$(./get-last-token.sh)
#echo 
curl -X GET ''$api_url'/products/listV2?pg=''&limit=100&cisStatus=APPLIED' -H 'Authorization: Bearer '$token''
#?cache=string&cis=string&cisAggregationState=string&cisPackageType=string&cisStatus=string
