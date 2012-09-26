module.exports = ->

  @Given /^I have a valid API key$/, (next) ->
    @apiKey = "validApiKey"
    next()