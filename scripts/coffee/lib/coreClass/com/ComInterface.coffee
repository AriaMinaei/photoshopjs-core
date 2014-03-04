module.exports = class ComInterface

	constructor: ->

		@_unassignedIDStartsAt = do ->

			i = 2500

			loop

				i++

				break if typeIDToStringID(i).length is 0

			i

	idMaybeValid: (id) ->

		id < @_unassignedIDStartsAt or id > @_unassignedIDStartsAt + 1000

	exec: (eventString, descCallback, showDialog = no) =>

		executer = new ActionExecuter eventString, descCallback, showDialog

		executer._execute()

	desc: =>

		return new Desc

	id: (what) =>

		if typeof what is 'number'

			unless @idMaybeValid what

				throw Error "typeID[#{what}] doesn't seem to be valid"

			str = typeIDToStringID what

			if str.length is 0

				throw Error "typeID[#{what}] doesn't translate to a stringID"

			console.log "Use stringID '#{str}' instead of typeID[#{what}]"

			return what

		unless typeof what is 'string'

			throw Error "Can't find typeID for a non-string: '#{what}'"

		if what.length is 0

			throw Error "Empty string/charID isn't valid"

		id = stringIDToTypeID what

		return id if @idMaybeValid id

		if what.length isnt 4

			console.warn "stringID '#{what}' doesn't seem to be valid"

			return id

		id = charIDToTypeID what

		str = typeIDToStringID id

		if str.length is 0

			throw Error "string/charID '#{what}' is most likely invalid"

		console.log "Use stringID '#{str}' instead of charID '#{what}'"

		id

Desc = require './Desc'
ActionExecuter = require './ActionExecuter'