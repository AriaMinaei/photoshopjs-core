DocumentsManager = require './DocumentsManager'
PanelHelper = require './tools/PanelHelper'
com = require 'photoshopjs-com'

module.exports = class CoreApi

	@create: (globalScope) ->

		fn = ->

		instance = new CoreApi fn, globalScope

		fn.__proto__ = instance

		fn

	constructor: (@_fn, @global) ->

		@com = com

		@docs = new DocumentsManager @

	panel: (name, cb) ->

		new PanelHelper @, name, cb

		return