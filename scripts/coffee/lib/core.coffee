CoreClass = require './CoreClass'
console = require './tools/console'
JSON = require './tools/JSON'

$.global.console = console
$.global.JSON = JSON

module.exports = CoreClass.create $.global