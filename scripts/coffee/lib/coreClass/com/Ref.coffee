module.exports = class Ref

	constructor: (reference = new ActionReference) ->

		@reference = self.refify reference

	prop: (cls, value) ->

		@reference.putProperty com.id(cls), com.id(value)

		@

	enum: (cls, enumType, value) ->

		@reference.putEnumerated com.id(cls), com.id(enumType), com.id(value)

		@

	self = @

	@refify: (ref) ->

		if ref instanceof Function

			ref = ref()

		if ref instanceof Ref

			return ref.reference

		unless ref instanceof ActionReference

			throw Error "The object is not an ActionReference"

		ref

com = require '../com'