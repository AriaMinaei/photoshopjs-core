Document = require './documentsManager/Document'

module.exports = class DocumentsManager

	constructor: (@_core) ->

		# It's a bit soon to think about multi-doc situations,
		# so I'm just gonna assume we have one document, and that's
		# the one that's currently active
		@active = new Document @