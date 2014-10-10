{desc, ref, list} = require 'photoshopjs-com'
Layer = require '../Layer'

Layer.extend

	move: (x, y) ->

		do @activate

		desc()
		.ref 'null', ref().enum 'layer', 'ordinal', 'targetEnum'
		.enum 'freeTransformCenterState', 'quadCenterState', 'QCSAverage'
		.obj 'offset', 'offset', ->

			desc()
			.unitDouble 'horizontal', 'pixelsUnit', parseFloat x
			.unitDouble 'vertical', 'pixelsUnit', parseFloat y

		.enum 'interfaceIconFrameDimmed', 'interpolationType', 'bicubic'
		.exec 'transform'

		@

	rotate: (ang, aroundArgs...) ->

		d = desc()
		.ref 'null', ref().enum 'layer', 'ordinal', 'targetEnum'

		@_modifyDescForAroundArgs d, aroundArgs

		d
		.unitDouble 'angle', 'angleUnit', parseFloat ang
		.enum 'interfaceIconFrameDimmed', 'interpolationType', 'bicubic'
		.exec 'transform'

		@

	_modifyDescForAroundArgs: (d, args) ->

		# midcenter by default
		unless args[0]?

			args[0] = 'midcenter'

		# any of the known sides or corners
		if aroundSides[args[0]]?

			d.enum 'freeTransformCenterState', 'quadCenterState', aroundSides[args[0]]

			return

		if typeof args[0] is 'number'

			x = args[0]

			if typeof args[1] is 'number'

				y = args[1]

			else

				y = x

			d
			.enum 'freeTransformCenterState', 'quadCenterState', 'QCSIndependent'
			.obj 'position', 'paint', ->

				desc()
				.unitDouble 'horizontal', 'pixelsUnit', parseFloat x
				.unitDouble 'vertical', 'pixelsUnit', parseFloat y

			return

		throw Error "Unkown set of arguments for rotation '#{args}'"

aroundSides =

	'topleft': 'QCSCorner0'
	'topcenter': 'QCSSide0'
	'topright': 'QCSCorner1'
	'midleft': 'QCSSide3'
	'midcenter': 'QCSAverage'
	'midright': 'QCSSide1'
	'bottomleft': 'QCSCorner3'
	'bottomcenter': 'QCSSide2'
	'bottomright': 'QCSCorner2'