exports.World = (next) ->
  @azure = require '../../service/node_modules/azure'
  @storageAccount = 'devstoreaccount1'
  @storageAccountKey = 'Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw=='
  @blobService = @azure.createBlobService this.storageAccount, this.storageAccountKey

  next()
