module.exports = JSON = {}

# from mootools

JSON.validate = (string) ->
	string = string.replace /\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@'
	.replace /"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']'
	.replace /(?:^|:|,)(?:\s*\[)+/g, ''

	return (/^[\],:{}\s]*$/).test(string)

JSON.parse = (string) ->

	return null unless typeof string is 'string'

	unless JSON.validate string

		throw Error "The given json is not secure: '#{string}'"

	eval "(#{string})"