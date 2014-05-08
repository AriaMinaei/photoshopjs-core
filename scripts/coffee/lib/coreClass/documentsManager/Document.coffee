GuidesManager = require './document/GuidesManager'
{desc, exec} = require '../com'

module.exports = class Document

	constructor: (@_docs) ->

		@_core = @_docs._core

		@guides = new GuidesManager @

		@_dom = null

		@_globalUnit = null

	getGlobalUnit: ->

		unless @_globalUnit?

			@_globalUnit = @asDom().width.type

		@_globalUnit

	globalUnitToPixels: (n) ->

		(new UnitValue n, @getGlobalUnit()).as 'px'

	asDom: ->

		unless @_dom?

			# http://www.ps-scripts.com/bb/viewtopic.php?f=5&t=4896&sid=193b860f8acc6665ce304e644b9f404a#p22758

			try

				doc = app.activeDocument

			catch

				$.sleep 500

				exec 'Wait', ->

					desc()
					.enum "Stte", "Stte", "RdCm"

				doc = app.activeDocument

			@_dom = doc

		@_dom