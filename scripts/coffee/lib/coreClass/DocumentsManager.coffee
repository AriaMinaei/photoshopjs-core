Document = require './documentsManager/Document'
{desc, exec} = require './com'

module.exports = class DocumentsManager

	constructor: (@_core) ->

		@active = new Document @

	getActiveDomDoc: ->

