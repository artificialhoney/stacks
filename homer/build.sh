#!/bin/bash

rm -rf ./dist
wget --mirror -p --convert-links -P ./dist http://localhost:8080
wget http://localhost:8080/sw.js -O ./dist/localhost:8080/sw.js
cp -rf ./theme/assets/* ./dist/localhost:8080/assets/
cp -f ./theme/LICENSE ./dist/localhost:8080/assets/
