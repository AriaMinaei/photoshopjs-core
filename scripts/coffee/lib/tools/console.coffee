module.exports = console =

	inspectLimit: 6

	native: no

	_inspectSingle: (given, limit = console.inspectLimit, covered = []) ->

		r = ''

		limit--

		if limit <= 0

			return (typeof given) + '-Limit!'

		if typeof given is 'object'

			if given in covered

				return '[Recursive]'

			else

				covered.push given

			items = []

			iterator = (v, k) ->

				k = "'" + k + "' -> "

				items.push k + console._inspectSingle(v, limit, covered)

			if given instanceof Array

				type = 'array'

				iterator(v, i) for v, i in given

			else

				type = 'object'

				iterator(v, k) for k, v of given

			r = prependToEachLine ("\n" + items.join(", \n")), '     '

		else if typeof given is 'function'

			r = 'function'

		else if given is undefined

			r = 'undefined'

		else

			r = given

		unless type

			type = typeof given

		'[' + type + '] -> ' + r


	_inspect: ->

		r = []

		r = for v in arguments

			console._inspectSingle(v)

		r.join("   ", r)

	log: ->

		@alert.apply @, arguments

	alert: ->

		alert(@_inspect.apply(@, arguments))

	error: (e) ->

		if typeof e is 'string'

			alert "Error: " + e

			throw e

		alert("Error: " + e.message + "\n"
			+ "@" + e.sourceURL + ":" + e.line
			)

		throw e

	notice: ->

		alert("Notice: " + Array.from(arguments).join(" "))

	type: (v) ->

		t = typeof v

		if t in ['string', 'number', 'boolean']

			alert(t + ': ' + v)

		alert(v)

prependToEachLine = (str, toPrepend) ->

	String(str).split("\n").join("\n" + toPrepend)