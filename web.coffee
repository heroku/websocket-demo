coffee  = require("coffee-script")
express = require("express")
http    = require("http")
ws      = require("ws")

app = express()

app.get "/", (req, res) ->
  res.sendfile "#{__dirname}/index.html"

app.get "/engine.io.js", (req, res) ->
  res.sendfile "#{__dirname}/node_modules/engine.io-client/engine.io.js"

server = http.createServer(app)

server.listen (process.env.PORT || 5000)

echo = new ws.Server(server:server)

echo.on "connection", (connection) ->
  connection.on "message", (message) ->
    connection.send message
