const AWS = require('aws-sdk');

exports.handler = async event => {
  console.log(`Connected`)
  return { statusCode: 200, body: JSON.stringify({ message : `Connected, now you can get random words from ${process.env.TABLE_NAME}.`}) };
};
