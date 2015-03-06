#!/usr/bin/env coffee
#encoding: UTF-8

dnsd = require('dnsd')

dnsd.createServer( (req, res) ->
  question = res.question[0]
  hostname = question.name
  length = hostname.length
  ttl = 3600
  hostname = hostname.toLowerCase()
  parts = hostname.split(".")
  domain = parts.slice(-2).join(".")

  console.log question

  if question.type is "NS" or question.type is "*"
    res.answer.push
      name: domain
      type: "NS"
      data: "ns.arm.fi"
      ttl: ttl

    res.answer.push
      name: domain
      type: "NS"
      data: "ns2.arm.fi"
      ttl: ttl
    res.end()
  else if question.type is "SOA" or question.type is "AAAA" or question.type is "*"
    res.answer.push
      name: domain
      type: "SOA"
      data:
        mname: "ns.arm.fi"
        rname: "webmaster@" + domain
        serial: 1
        refresh: 86400
        retry: 120
        expire: 1209600
        ttl: 3601
      ttl: 3602
    res.end()
  else
    res.end('178.251.144.67')
).listen(53)

console.log 'Server running at 53'
