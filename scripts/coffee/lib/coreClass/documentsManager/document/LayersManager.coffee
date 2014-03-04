module.exports = class LayersManager

	constructor: (@document) ->

	count: ->

		# todo: add link to the post in ps-scripts where I found this

		get ->

			ref()
			.prop 'property', 'numberOfLayers'
			.enum 'document', 'ordinal', 'targetEnum'

		.getInt 'NmbL'