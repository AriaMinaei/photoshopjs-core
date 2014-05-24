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

	exec: (event, desc, showDialog = no) =>

		new ActionExecuter event, desc, showDialog

	get: (ref) =>

		ref = Ref.refify ref

		new Desc executeActionGet ref

	desc: =>

		new Desc

	ref: =>

		new Ref

	id: (what) =>

		# direct typeID
		if typeof what is 'number'

			unless @idMaybeValid what

				throw Error "typeID[#{what}] doesn't seem to be valid"

			str = typeIDToStringID what

			if str.length is 0

				throw Error "typeID[#{what}] doesn't translate to a stringID"

			# console.log "Use stringID '#{str}' instead of typeID[#{what}]"

			return what

		unless typeof what is 'string'

			throw Error "Can't find typeID for a non-string: '#{what}'"

		if what.length is 0

			throw Error "Empty string/charID isn't valid"

		if what.length is 4

			id = charIDToTypeID what

			str = typeIDToStringID id

			if str.length > 0

				# console.log "Use stringID '#{str}' instead of charID '#{what}'"

				return id

		id = stringIDToTypeID what

		# unless @idMaybeValid id

		# 	console.warn "stringID '#{what}' doesn't seem to be valid"

		id

Ref = require './Ref'
Desc = require './Desc'
ActionExecuter = require './ActionExecuter'