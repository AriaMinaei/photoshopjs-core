{desc, ref, list} = require 'photoshopjs-com'
Layer = require '../Layer'

Layer.extend

	setOpacity: (op) ->

		do @activate

		desc()
		.ref 'null', ref().enum 'layer', 'ordinal', 'targetEnum'
		.obj 'to', 'layer', desc().unitDouble 'opacity', 'percentUnit', parseFloat op
		.exec 'set'

		@

	setFillOpacity: (op) ->

		do @activate

		desc()
		.ref 'null', ref().enum 'layer', 'ordinal', 'targetEnum'
		.obj 'to', 'layer', desc().unitDouble 'fillOpacity', 'percentUnit', parseFloat op
		.exec 'set'

		@