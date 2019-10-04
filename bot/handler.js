// handler.js
const { serverless } = require('@probot/serverless-lambda')
const appFn = require('./bot')
module.exports.probot = serverless(appFn)