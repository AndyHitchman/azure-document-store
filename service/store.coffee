azure = require 'azure'

class Store

  start: (router, options) ->
    console.log "Starting document store"
    blobService = azure.createBlobService options.storageAccount.name, options.storageAccount.key

    router.path /\/(.*)/, ->
      @get (path) -> 
        @res.writeHead(200)
        @res.end

module.exports = new Store()