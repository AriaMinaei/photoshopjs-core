JSON = require '../tools/JSON'

module.exports = class PanelHelper

	constructor: (@_core, panelName, cb) ->

		unless @_core.global._panels?

			@_core.global._panels = {}

		core = @_core

		@_core.global._panels[panelName] = (args) ->

			result = null

			if typeof args[0] is 'string' and args[0][0] is '{'

				# CS
				args = JSON.parse args[0]

			run = ->

				console.useAlert()

				result = cb args

				console.useLog()

			try

				try

					doc = core.docs.active

					domDoc = doc.asDom()

				if domDoc?

					domDoc.suspendHistory(panelName, 'run()')

				else

					do run

				return "ok;" + result

			catch error

				msg = error

				if error.message?

					msg = error.message

				alert msg

				return "er;" + console._inspectSingle error