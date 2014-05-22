{exec, desc, charToType, stringToType, stringToChar, typeToString} = require '../../com'

module.exports = class GuidesManager

	constructor: (@_doc) ->

		@_core = @_doc._core

	addHorizontal: (positions...) ->

		# @_add "horizontal", positions
		@_add Direction.HORIZONTAL, positions

		@

	addVertical: (positions...) ->

		# @_add "vertical", positions
		@_add Direction.VERTICAL, positions

		@

	_add: (orientation, positions) ->

		for pos in positions

			@_addSingle orientation, pos

		return

	_addSingle: (orientation, position) ->

		@_doc.asDom().guides.add(orientation, position)

		return

		# exec 'make', =>

		# 	desc()
		# 	.obj 'new', 'guide', =>

		# 		desc()
		# 		# .unitDouble 'position', @_doc.stringIDOfDefaultUnit() , position
		# 		.unitDouble 'position', 'pixelsUnit', @_doc.globalUnitToPixels(position)
		# 		.enum 'orientation', 'orientation', orientation

		# return