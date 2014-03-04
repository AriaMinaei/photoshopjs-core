module.exports = com = {}

ComInterface = require './com/ComInterface'

com.instance = new ComInterface

for own name of com.instance

	com[name] = com.instance[name]