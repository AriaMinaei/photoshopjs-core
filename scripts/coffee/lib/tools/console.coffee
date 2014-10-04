hasProp = {}.hasOwnProperty

module.exports = console =

	inspectLimit: 500

	actionListLimit: 5

	native: no

	_useAlert: no

	useAlert: ->

		self._useAlert = yes

		self

	useLog: ->

		self._useAlert = no

		self

	_inspectSingle: (given, persist = {limit: console.inspectLimit, covered: []}) ->

		r = ''

		if given is null

			return 'null'

		if typeof given in ['object', 'function']

			return @_inspectIterable given, persist

		else if given is undefined

			return 'undefined'

		else if typeof given is 'string'

			if given.length > 200

				given = given.substr 0, 200

			return '"' + given + '"'

		else if typeof given in ['boolean', 'number']

			return String given

		else

			r = given

		unless type

			type = typeof given

		type + ' -> ' + r

	_inspectIterable: (given, persist) ->

		if given in persist.covered then return '[Recursive]' else persist.covered.push given

		items = []

		iterator = (v, k) ->

			persist.limit--

			return if persist.limit <= 0

			k = k + " -> "

			items.push k + console._inspectSingle(v, persist)

		if given instanceof Array

			type = 'array'

			@_iterateArray given, iterator

		else

			if typeof given is 'function'

				type = '#Function'

			else

				type = '#Object'

				if given.constructor?.name?

					name = given.constructor.name

					if name isnt 'Object'

						type = '#' + name

			if isPhotoshopThingy given

				@_iteratePhotoshopThingy given, iterator

			else

				@_iterateObject given, iterator

		r = prependToEachLine ("\n" + items.join(", \n")), '   '

		type + ' -> ' + r

	_iterateArray: (given, iterator) ->

		iterator(v, i) for v, i in given

		return

	_iterateObject: (given, iterator) ->

		for k of given

			continue if k in ['prototype', 'parent']

			try

				continue unless hasProp.call(given, k)

			catch

				continue

			try

				v = given[k]

				iterator(v, k)

		return

	_iteratePhotoshopThingy: (given, iterator) ->

		if given.constructor is ActionDescriptor

			@_iterateActionDescriptor given, iterator

		else if given.constructor is ActionList

			@_iterateActionList given, iterator

		else if given.constructor is ActionReference

			@_iterateActionReference given, iterator

	_iterateActionDescriptor: (d, iterator) ->

		# I learned this from:
		# https://github.com/dfcreative/photoshopr/blob/master/include/debug.jsxinc
		#
		# Thanks to @dfcreative
		for i in [0...d.count]

			id = d.getKey i
			keyName = t2s id
			type = d.getType id

			if type is DescValueType.INTEGERTYPE

				iterator d.getInteger(id), "#{keyName}(int)"

			else if type is DescValueType.STRINGTYPE

				iterator d.getString(id), "#{keyName}(string)"

			else if type is DescValueType.DOUBLETYPE

				iterator d.getDouble(id), "#{keyName}(double)"

			else if type is DescValueType.BOOLEANTYPE

				iterator d.getBoolean(id), "#{keyName}(bool)"

			else if type is DescValueType.UNITDOUBLE
				# not tested
				iterator d.getUnitDoubleValue(id), "#{keyName}(unitDouble, #{t2s(d.getUnitDoubleType(id))})"

			else if type is DescValueType.ENUMERATEDTYPE

				iterator t2s(d.getEnumerationValue(id)), "#{keyName}(enum)"

			else if type is DescValueType.LISTTYPE

				iterator d.getList(id), "#{keyName}(list)"

			else if type is DescValueType.OBJECTTYPE

				iterator d.getObjectValue(id), "#{keyName}(object)"

			else

				iterator "unkown", "#{keyName}(object)"

		return

	_iterateActionList: (l, iterator) ->

		for i in [0...l.count]

			type = l.getType i

			if i is 0

				iterator shortenDescValueType(type), "$type"

			if i > console.actionListLimit - 1

				iterator l.count, "total"

				break

			if type is DescValueType.INTEGERTYPE

				iterator l.getInteger(i), i

			else if type is DescValueType.STRINGTYPE

				iterator l.getString(i), i

			else if type is DescValueType.DOUBLETYPE

				iterator l.getDouble(i), i

			else if type is DescValueType.BOOLEANTYPE

				iterator l.getBoolean(i), i

			else if type is DescValueType.UNITDOUBLE
				# not tested
				iterator l.getUnitDoubleValue(i), i

			else if type is DescValueType.ENUMERATEDTYPE

				iterator t2s(l.getEnumerationValue(i)), i

			else if type is DescValueType.LISTTYPE

				iterator l.getList(i), i

			else if type is DescValueType.OBJECTTYPE

				iterator l.getObjectValue(i), i

			else if type is DescValueType.REFERENCETYPE

				iterator l.getReference(i), i

			else

				iterator "unkown", "#{i}(unkown)"

		return

	_iterateActionReference: (ref, persist) ->

		@_iterateActionDescriptor executeActionGet(ref), persist

	_output: (s) ->

		if self._useAlert

			alert s

		else

			$.write '\n----------------------\n' + s + '\n'

		return

	_inspect: (args) ->

		r = for v in args

			console._inspectSingle v

		r.join "   "

	log: ->

		self._output self._inspect arguments

	alert: ->

		alert self._inspect.apply(self, arguments)

	error: (e) ->

		if typeof e is 'string'

			self._output "Error: " + e

			throw e

		self._output("Error: " + e.message + "\n"
			+ "@" + e.sourceURL + ":" + e.line
			)

		throw e

	warn: (args...) ->

		args.unshift 'Warning'

		@log.apply @, args

	typeOf: (what) ->

		if what is null

			return 'null'

		switch typeof what

			when 'string' then return 'String'

			when 'number' then return 'Number'

			when 'boolean' then return 'Boolean'

			when 'undefined' then return 'undefined'

			when 'object'

				if what instanceof Function

					return 'Function'

				return '#' + what.constructor.name

			else

				return typeof what

	notice: ->

		args.unshift 'Notice'

		@log.apply @, args

	keys: (obj) ->

		unless typeof obj is 'object'

			return @console.apply @, arguments

		s = ''

		for k of obj

 			try

 				v = obj[k]

 				type = @typeOf v

 			catch

 				type = '#inaccessible'

 			s += '\n   ' + k + ' -> ' + type

 		@_output s

 		return


self = console

prependToEachLine = (str, toPrepend) ->

	String(str).split("\n").join("\n" + toPrepend)

s2t = stringIDToTypeID
t2s = typeIDToStringID

isPhotoshopThingy = (thingy) ->

	c = thingy.constructor

	return no unless c?

	return yes if c in [ActionDescriptor, ActionList, ActionReference]

	no

shortenDescValueType = (type) ->

	return switch type

		when DescValueType.LISTTYPE

			"list"

		when DescValueType.INTEGERTYPE

			"int"

		when DescValueType.ENUMERATEDTYPE

			"enum"

		when DescValueType.STRINGTYPE

			"str"

		when DescValueType.DOUBLETYPE

			"double"

		when DescValueType.BOOLEANTYPE

			"bool"

		when DescValueType.OBJECTTYPE

			"obj"

		when DescValueType.ALIASTYPE

			"alias"

		when DescValueType.CLASSTYPE

			"class"

		when DescValueType.UNITDOUBLE

			"unitDouble"

		when DescValueType.REFERENCETYPE

			"ref"

		when DescValueType.RAWTYPE

			"raw"

		else

			t2s(type)