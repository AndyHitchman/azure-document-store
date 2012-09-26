azure = require 'azure'
http = require 'http'
director = require 'director'
store = require './store'

azure.RoleEnvironment.isAvailable (err, available) ->
  options = if available then require('./options').cloud else require('./options').development
  
  router = new director.http.Router()
  store.start router, options

  server = http.createServer (req, res) ->
    router.dispatch req, res, (err) ->
      console.log "Served #{req.url}"
      if err?
        res.writeHead(500)
        res.end()

  console.log "Listening on port #{options.server.port}"
  server.listen options.server.port
  server.on 'close', ->
    console.log "Server closing"

  exports.server = server
