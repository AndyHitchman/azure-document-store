azure = require 'azure'
pipette = require 'pipette'
url = require 'url'

module.exports = class Store

  constructor: (options) ->
    console.log 'Starting document store'
    @blobService = azure.createBlobService options.storageAccount.name, options.storageAccount.key

  request: (req, res) =>
    [container, blobPath] = @splitContainerAndPath req.url

    #We want to make a single request to blob storage to retrieve the blob, yet also want to set the success 
    #status code before we stream content in the response body. 
    #Using an intermediate stream.
    intermediate = new pipette.Pipe()
    valve = new pipette.Valve intermediate.reader, {paused: true}
    valve.on 'data', (chunk) -> res.write chunk
    valve.on 'end', -> res.end()

    @blobService.getBlobToStream container, blobPath, intermediate.writer, (err, blobRef) ->
      return endError err, res if err?

      res.writeHead 200, 
        'Content-Type' : blobRef.contentType
        'Content-Length' : blobRef.contentLength
        'ETag' : blobRef.etag
        'Last-Modified' : blobRef.lastModified

      valve.resume()

  splitContainerAndPath: (reqUrl) ->
    [leading, container, blobPathParts...] = url.parse(reqUrl).pathname.split '/'
    blobPath = blobPathParts.join '/'
    [container, blobPath]

  endError: (err, res) ->
    res.writeHead err.status
    res.end()