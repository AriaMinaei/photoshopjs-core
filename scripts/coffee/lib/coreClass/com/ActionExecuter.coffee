module.exports = class ActionExecuter

	constructor: (event, desc, showDialog = no) ->

		@event = com.id event

		@showDialog = if showDialog is yes then DialogModes.YES else DialogModes.NO

		@desc = Desc.descify desc

		@result = null

	_execute: ->

		@result = executeAction @event, @desc, @showDialog

		@

com = require '../com'
Desc = require './Desc'