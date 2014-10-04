module.exports = class Desc

	constructor: (descriptor = new ActionDescriptor) ->

		@descriptor = self.descify descriptor

	# Sets the value for a key whose type is an object, represented by an
	# Action Descriptor
	obj: (key, cls, desc) ->

		@descriptor.putObject com.type(key), com.type(cls), self.descify(desc)

		@

	# Sets the value for a key whose type is string
	str: (key, value) ->

		@descriptor.putString com.type(key), value

		@

	# Sets the value for a key whose type is a unit value formatted as a double
	unitDouble: (key, unit, num) ->

		@descriptor.putUnitDouble com.type(key), com.type(unit), num

		@

	# Sets the enumeration type and value for a key
	enum: (key, type, enumValue) ->

		@descriptor.putEnumerated com.type(key), com.type(type), com.type(enumValue)

		@

	# Sets the value for a key whose type is an object reference
	ref: (key, ref) ->

		@descriptor.putReference com.type(key), Ref.refify(ref)

		@

	# Gets the value of a key of type integer
	getInt: (key) ->

		@descriptor.getInteger com.type(key)

	# Gets the value of a key of type string
	getStr: (key) ->

		@descriptor.getString com.type(key)

	# Gets the value of a key of type list
	getList: (key) ->

		com.list @descriptor.getList com.type key

	# Gets the enumeration type of a key
	getEnumValue: (key) ->

		com.string @descriptor.getEnumerationValue(com.type(key))

	# Checks whether the descriptor contains the provided key
	hasKey: (key) ->

		@descriptor.hasKey com.type key

	# apply executeAction on this descriptor
	exec: (eventName, showDialog) ->

		com.exec eventName, @, showDialog

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
Ref = require './Ref'