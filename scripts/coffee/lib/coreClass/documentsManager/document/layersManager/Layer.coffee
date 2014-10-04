module.exports = class Layer

	constructor: (@_manager, @descriptor, @id) ->

	getName: ->

		@descriptor.getStr "name"