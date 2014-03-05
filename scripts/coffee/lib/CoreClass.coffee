DocumentsManager = require './coreClass/DocumentsManager'
PanelHelper = require './coreClass/PanelHelper'
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

	panel: (name, cb) ->

		new PanelHelper @, name, cb

		return