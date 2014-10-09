{desc, ref, list} = require 'photoshopjs-com'

module.exports = class Layer

	constructor: (@_manager, @id, @descriptor) ->

		@_ref = null

	getName: ->

		@getReference().execGet().getStr "name"

	setName: (name) ->

		desc()
		.ref 'null', @getReference()
		.exec 'select'

		desc()
		.ref 'null', @getReference()
		.obj 'to', 'layer', ->

			desc()
			.str 'name', name

		.exec "set"

		@

	getReference: ->

		unless @_ref?

			@_ref = ref().ident 'layer', @id

		@_ref