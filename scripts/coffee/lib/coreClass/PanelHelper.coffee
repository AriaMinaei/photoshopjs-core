module.exports = class PanelHelper

	constructor: (@_core, panelName, cb) ->

		unless @_core.global._panel?

			@_core.global._panel = {}

		@_core.global._panel[panelName] = (received) ->

			run = ->

				console.useAlert()

				args = JSON.parse received[0]

				cb args

				console.useLog()

			do run