http = require 'http'
supertest = require 'supertest'
fs = require 'fs'
path = require 'path'

module.exports = ->

  @When /^I get the document '(.*?)'$/, (document, next) ->
    @request = supertest(@server).get document
    @responseBody = ""
    next()

  @Then /^I should get a '(\d+)' response$/, (statusCode, next) ->
    @request.expect Number(statusCode), (err, res) =>
      @response = res
      return next.fail err if err? 

      res.on 'data', (chunk) =>
        @responseBody += chunk

      res.on 'end', ->
        next()

  @Then /^the response content should match the local document '(.*?)'$/, (localPath, next) ->
    localFile = path.join 'features/content', localPath
    fs.readFile localFile, (err, fileContent) =>
      return next.fail err if err? 
      return next.fail "Content does not match expected local file" if fileContent.toString() != @responseBody
      next()
