director = require '../../service/node_modules/director'

module.exports = ->

  @Before (next) ->
    @azure = require '../../service/node_modules/azure'
    storageAccount = 
      name: 'devstoreaccount1'
      key: 'Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw=='
    @blobService = @azure.createBlobService storageAccount.name, storageAccount.key
    @router = new director.http.Router()
    @store = require '../../service/store'
    @store.start @router, { storageAccount }

    next()

  @After (next) ->
    next()