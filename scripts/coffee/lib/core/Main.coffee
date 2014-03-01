module.exports = class Main

	constructor: (root) ->

		invokable = ->

			invokable._invoke.apply invokable, arguments

		invokable.name = 'photoshopjs'

		invokable._root = root

		invokable._invoke = ->

		self._addPropsTo invokable

		self._invokables.push invokable

		return invokable

	self = @

	@_props = {}

	@_invokables = []

	@extend: (name, value) ->

		if typeof arguments[0] is 'object'

			for k, v of arguments[0]

				self.extend k, v

			return

		self._props[name] = value

		for invokable in self._invokables

			invokable[name] = value

		@

	@_addPropsTo = (fn) ->

		for name, value of self._props

			fn[name] = value

		return

Main.extend

	registerAs: (name) ->

		if @_root[name]?

			@_root._conflictedVar = @_root[name]

		@_name = name

		@_root[name] = @

		@

	noConflict: ->

		if @_conflictedVar?

			@_root[@_name] = @_conflictedVar

		@

	getConflict: ->

		@_conflictedVar