GuidesManager = require './document/GuidesManager'
LayersManager = require './document/LayersManager'
{desc} = require 'photoshopjs-com'

module.exports = class Document

	constructor: (@_docs) ->

		@_core = @_docs._core

		@guides = new GuidesManager @

		@layers = new LayersManager @

		@_dom = null

	# We're assuming this document is always active, so this
	# method doesn't do anything right now
	activate: ->

		@

	# Returns the Photoshop Dom object of the current document
	asDom: ->

		# http://www.ps-scripts.com/bb/viewtopic.php?f=5&t=4896&sid=193b860f8acc6665ce304e644b9f404a#p22758

		unless @_dom?

			try

				doc = app.activeDocument

			catch

				app.refresh()

			finally

				$.sleep 500

				desc()
				.enum "state", "state", "redrawComplete"
			 "wait"

				doc = app.activeDocument

			@_dom = doc

		@_dom