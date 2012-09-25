azure = require 'azure'
http = require 'http'
director = require 'director'

azure.RoleEnvironment.isAvailable (err, available) ->
  options = if available then require('./options').cloud else require('./options').development

  router = new director.http.Router()

  router.path(/)


  server = http.createServer (req, res) ->
    router.dispatch req, res, (err) ->
      console.log "Served #{req.url}"
      if err?
        res.writeHead(500)
        res.end()

  console.log "Listening on port #{options.server.port}"
  server.listen options.server.port

