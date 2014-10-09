CoreApi = require './CoreApi'
console = require './tools/console'
JSON = require './tools/JSON'

$.global.console = console
$.global.JSON = JSON

module.exports = CoreApi.create $.global