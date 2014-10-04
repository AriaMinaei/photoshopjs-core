module.exports = class ComInterface

	constructor: ->

		@_strings = {}
		@_types = {}

	type: (what) =>

		if typeof what is 'number'

			return what

		unless typeof what is 'string'

			throw Error "Can't find typeID for a non-string: '#{what}'"

		if what.length is 0

			throw Error "Empty string/charID isn't valid"

		@stringToType what

	string: (what) =>

		if typeof what is 'number'

			return @typeToString what

		unless typeof what is 'string'

			throw Error "Input is not a number, nor a string"

		what

	stringToType: (string) =>

		tid = @_strings[string]

		return tid if tid?

		tid = stringIDToTypeID string

		@_strings[string] = tid

		tid

	typeToString: (type) =>

		sid = @_types[type]

		return sid if sid?

		sid = typeIDToStringID type

		@_types[type] = sid

		sid

	exec: (event, desc, showDialog = no) =>

		showDialog = if showDialog is yes then DialogModes.YES else DialogModes.NO

		desc = Desc.descify desc

		result = executeAction(@type(event), desc, showDialog)

		@desc result

	desc: (d) =>

		new Desc d

	ref: (r) =>

		new Ref r

	list: (l) =>

		new List l

Ref = require './Ref'
Desc = require './Desc'
List = require './List'