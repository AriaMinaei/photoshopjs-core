module.exports = class Ref

	constructor: (reference = new ActionReference) ->

		@reference = self.refify reference

	# Puts a new property and value into the reference
	prop: (cls, value) ->

		@reference.putProperty com.type(cls), com.type(value)

		@

	# Puts an enumeration type and ID into a reference along with the desired class for the reference
	enum: (cls, enumType, value) ->

		@reference.putEnumerated com.type(cls), com.type(enumType), com.type(value)

		@

	# Puts a new identifier and value into the reference
	ident: (cls, value) ->

		@reference.putIdentifier com.type(cls), value

		@

	# Puts a new index and value into the reference
	index: (cls, value) ->

		@reference.putIndex com.type(cls), value

		@

	# Gets the index value for a reference in a list or array
	getIndex: ->

		@reference.getIndex()

	execGet: ->

		com.desc executeActionGet @reference

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