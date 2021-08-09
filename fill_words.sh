#!/bin/bash
for i in $(seq 1 $NUMBER_OF_WORDS); do 
    # x=$(curl -s https://random-word-api.herokuapp.com/word)
    # x="$(echo $x | sed 's/"//g' | sed 's/\[//g' | sed 's/\]//g')"
    WORD=$(curl -s https://random-word-api.herokuapp.com/word | jq -r '.[0]' ) 
    echo Pushing $WORD
    aws dynamodb put-item --table-name $TABLE_NAME --item "{\"word\": { \"S\": \"$WORD\" } }" --region $AWS_REGION
done
