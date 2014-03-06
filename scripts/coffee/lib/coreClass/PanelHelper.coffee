module.exports = class PanelHelper

	constructor: (@_core, panelName, cb) ->

		unless @_core.global._panels?

			@_core.global._panels = {}

		@_core.global._panels[panelName] = (args) ->

			run = ->

				console.useAlert()

				cb args

				console.useLog()

			try

				ret = do run

				return "ok;" + ret

			catch error

				return "er;" + console._inspectSingle error