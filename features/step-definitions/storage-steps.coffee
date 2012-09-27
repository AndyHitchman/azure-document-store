path = require 'path'

module.exports = ->
  #@World = require('../support/world.coffee').World

  @Given /^the '([a-z0-9-]{3,63})' container exists$/, (containerName, next) ->
    @blobService.deleteContainer containerName, (err) =>
      @blobService.createContainer containerName, (err) =>
        return next.fail err if err?
        next()

  @Given /^the storage container '([a-z0-9-]{3,63})' has no document at '(.*?)'$/, (containerName, blobPath, next) ->
    @blobService.deleteBlob containerName, blobPath, { accessConditions: { 'If-Match': '*' }}, (err) =>
      next()

  @Given /^the storage container '([a-z0-9-]{3,63})' has the local document '(.*?)' of type '(.*?)' at '(.*?)'$/, 
    (containerName, localPath, contentType, blobPath, next) ->
      localFile = path.join 'features/content', localPath
      @blobService.createBlockBlobFromFile containerName, blobPath, localFile, { contentType: contentType, accessConditions: { 'If-Match': '*' }}, (err) =>
        return next.fail err if err?
        next()
