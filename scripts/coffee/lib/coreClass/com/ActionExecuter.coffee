module.exports = class ActionExecuter

	constructor: (@event, desc, showDialog = no) ->

		@showDialog = if showDialog is yes then DialogModes.YES else DialogModes.NO

		@desc = Desc.descify desc

		@result = executeAction com.id(@event), @desc, @showDialog


com = require '../com'
Desc = require './Desc'