DocumentsManager = require './coreClass/DocumentsManager'
com = require './coreClass/com'

module.exports = class CoreClass

	@create: (globalScope) ->

		fn = ->

		instance = new CoreClass fn, globalScope

		fn.__proto__ = instance

		fn

	constructor: (@_fn, @global) ->

		@com = com

		@docs = new DocumentsManager @