http = require 'http'

module.exports = ->

  @When /^I get the document '(.*?)'$/, (document, next) ->
    next.pending()

  @Then /^I should get a '(\d+)' response$/, (statusCode, next) ->


    next.pending()