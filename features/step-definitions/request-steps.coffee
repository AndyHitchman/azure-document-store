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

      if res.buffered
        @responseBody = res.text
        return next()

      res.on 'data', (chunk) =>
        console.log "chunk"
        @responseBody += chunk

      res.on 'end', ->
        console.log "end"
        next()

  @Then /^the response content should match the local document '(.*?)'$/, (localPath, next) ->
    localFile = path.join 'features/content', localPath
    fs.readFile localFile, (err, fileContent) =>
      return next.fail err if err? 
      return next.fail "Content does not match expected local file" if fileContent.toString() != @responseBody
      next()

  @Then /^the response content type should be '(.*?)'$/, (contentType, next) ->
    return next.fail "Content-Type does not match #{contentType}" if contentType != @response.type
    next()