const AWS = require('aws-sdk');
const dynamoDBClient = new AWS.DynamoDB(); 

exports.handler = async event => {
  let randomUID = (Math.random() + 1).toString(36).substring(2, 5);
  console.log(`random`, randomUID);
  
  let lastKeyEvaluated = {
    word: {S: randomUID}
  }
  
  try {
    let dynamodb_response = await dynamoDBClient.scan(
      {
        TableName: process.env.TABLE_NAME,
        ExclusiveStartKey: lastKeyEvaluated,
        Limit: 1,
        ReturnConsumedCapacity: `TOTAL`
      }
    ).promise();

    console.log(dynamodb_response)
  
    let randomWord = dynamodb_response.Items[0].word.S;
    
    console.log(`Getting word`)
    return { statusCode: 200, body: JSON.stringify({ message : `Your random word is ${randomWord}.` }) };
  } catch (error) {
    console.log(`Error:`, error);
    return { statusCode: 500, body: JSON.stringify({ error : `We weren't able to get words from ${process.env.TABLE_NAME}` }) };
  } 
};
