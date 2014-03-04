{exec, desc, charToType, stringToType, stringToChar, typeToString} = require '../../com'

module.exports = class GuidesManager

	constructor: (@_doc) ->

		@_core = @_doc._core

	addHorizontal: (positions...) ->

		@_add "horizontal", positions

		@

	addVertical: (positions...) ->

		@_add "vertical", positions

		@

	_add: (orientation, positions) ->

		for pos in positions

			@_addSingle orientation, pos

		return

	_addSingle: (orientation, position) ->

		exec 'make', =>

			desc()
			.obj 'new', 'guide', =>

				desc()
				.unitDouble 'position', 'pixelsUnit', @_doc.globalUnitToPixel(position)
				.enum 'orientation', 'orientation', orientation

		return