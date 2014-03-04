Document = require './documentsManager/Document'

module.exports = class DocumentsManager

	constructor: (@_core) ->

		@active = new Document @