module.exports = ->
  @World = require('../support/world.coffee').World

  @Given /^I have a valid API key$/, (next) ->
    @apiKey = "validApiKey"
    next()