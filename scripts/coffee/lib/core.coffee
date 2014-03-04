CoreClass = require './CoreClass'
console = require './tools/console'

$.global.console = console

module.exports = CoreClass.create $.global