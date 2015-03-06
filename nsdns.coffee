#!/usr/bin/env coffee
#encoding: UTF-8


dnsd = require('dnsd')

dnsd.createServer( (req, res) ->
  res.end('1.2.3.4')
).listen(53, '20.20.20.21')

console.log 'Server running at 53'
