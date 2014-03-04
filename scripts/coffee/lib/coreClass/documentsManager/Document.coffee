GuidesManager = require './document/GuidesManager'

module.exports = class Document

	constructor: (@_docs) ->

		@_core = @_docs._core

		@guides = new GuidesManager @