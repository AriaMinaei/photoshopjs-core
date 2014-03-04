module.exports = class Desc

	constructor: ->

		@descriptor = new ActionDescriptor

	obj: (key, cls, desc) ->

		@descriptor.putObject com.id(key), com.id(cls), self.descify(desc)

		@

	unitDouble: (key, unit, num) ->

		@descriptor.putUnitDouble com.id(key), com.id(unit), num

		@

	enum: (key, type, enumValue) ->

		@descriptor.putEnumerated com.id(key), com.id(type), com.id(enumValue)

		@

	self = @

	@descify: (desc) ->

		if desc instanceof Function

			desc = desc()

		if desc instanceof Desc

			return desc.descriptor

		unless desc instanceof ActionDescriptor

			throw Error "The object is not an ActionDescriptor"

		desc

com = require '../com'