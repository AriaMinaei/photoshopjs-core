module.exports = console =

	inspectLimit: 100

	native: no

	_useAlert: no

	useAlert: ->

		self._useAlert = yes

		self

	_inspectSingle: (given, persist = {limit: console.inspectLimit, covered: []}) ->

		r = ''

		if given is null

			return 'null'

		if typeof given in ['object', 'function']

			if given in persist.covered

				return '[Recursive]'

			else

				persist.covered.push given

			items = []

			iterator = (v, k) ->

				persist.limit--

				return if persist.limit <= 0

				k = k + " -> "

				items.push k + console._inspectSingle(v, persist)

			if given instanceof Array

				type = 'array'

				iterator(v, i) for v, i in given

			else

				if typeof given is 'function'

					type = '#Function'

				else

					type = '#Object'

					if given.constructor?.name?

						name = given.constructor.name

						if name isnt 'Object'

							type = '#' + name

				for k of given

					continue if k in ['prototype', 'parent']

					try

						v = given[k]

						iterator(v, k)

			r = prependToEachLine ("\n" + items.join(", \n")), '   '

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

	_inspect: (args) ->

		r = for v in args

			console._inspectSingle v

		r.join "   "

	_output: (s) ->

		if self._useAlert

			alert s

		else

			$.write '\n----------------------\n' + s + '\n'

		return

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