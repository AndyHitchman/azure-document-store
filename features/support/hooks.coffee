module.exports = ->

  @Before (next) ->
    @azure = require '../../service/node_modules/azure'
    storageAccount = 
      name: 'devstoreaccount1'
      key: 'Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw=='
    @blobService = @azure.createBlobService storageAccount.name, storageAccount.key
    @server = require('../../service/server').server

    next()

  @After (next) ->
    @server.close()
    next()