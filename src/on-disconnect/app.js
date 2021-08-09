const AWS = require('aws-sdk');

exports.handler = async event => {
  console.log(`Disconnected`)
  return { statusCode: 200, body: JSON.stringify({ message: `Bye` }) };
};
