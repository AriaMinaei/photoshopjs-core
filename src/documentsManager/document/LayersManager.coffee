{ref, desc} = require 'photoshopjs-com'
Layer = require './layersManager/Layer'

module.exports = class LayersManager

	constructor: (@document) ->

		@_core = @document

		@_layersById = {}

		@_activeLayers = []

		@_activeLayerSituationRectified = no

	hasActiveLayer: ->

		do @_rectifyActiveLayerSituation

		@_activeLayers.length is 1

	hasMultipleActiveLayers: ->

		do @_rectifyActiveLayerSituation

		@_activeLayers.length > 1

	getActive: ->

		do @_rectifyActiveLayerSituation

		@_activeLayers

	getActiveLayer: ->

		do @_rectifyActiveLayerSituation

		return null if @_activeLayers.length isnt 1

		@_activeLayers[0]

	_rectifyActiveLayerSituation: ->

		return if @_activeLayerSituationRectified

		@_activeLayerSituationRectified = yes

		activeLayersDesc = ref()
		.enum 'document', 'ordinal', 'targetEnum'
		.execGet()

		if activeLayersDesc.hasKey 'targetLayers'

			list = activeLayersDesc.getList 'targetLayers'

			for i in [0...list.getCount()]

				layerDesc = list.getDesc(i)

				@_activeLayers.push @_introduceLayerByDesc layerDesc

		else

			layerDesc = ref()
			.enum 'layer', 'ordinal', 'targetEnum'
			.execGet()

			@_activeLayers.push @_introduceLayerByDesc layerDesc

		return

	_introduceLayerByDesc: (d) ->

		id = d.getInt 'layerID'

		if @_layersById[id]?

			return @_layersById[id]

		l = @_layersById[id] = new Layer @, id, d

		l

	_getLayerRefByID: (id) ->

		ref().ident 'layer', id

	reactivate: (layers) ->

		console.log layers.length

		unless layers instanceof Array

			layers = [layers]

		for l, i in layers

			d = desc()
			.ref 'null', l.getReference()

			d.enum 'selectionModifier', 'selectionModifierType', 'addToSelection' if i > 0

			d.exec 'select'

			@_activeLayers[i] = l

		@_activeLayers.length = layers.length

		@