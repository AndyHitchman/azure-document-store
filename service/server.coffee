azure = require 'azure'
http = require 'http'
Store = require './store'

server = exports.server = http.createServer()

azure.RoleEnvironment.isAvailable (err, available) ->
  options = if available then require('./options').cloud else require('./options').development
  
  store = new Store options

  server.on 'request', store.request
  server.on 'close', -> console.log "Server closing"

  server.listen options.server.port
  console.log "Listening on port #{options.server.port}"