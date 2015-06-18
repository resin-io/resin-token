###
The MIT License

Copyright (c) 2015 Resin.io, Inc. https://resin.io.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
###

###*
# @module token
###

Promise = require('bluebird')
atob = require('atob')
errors = require('resin-errors')
storage = require('./storage')

TOKEN_KEY = 'token'

###*
# @summary Set the token
# @function
# @public
#
# @param {String} token - token
# @returns {Promise<String>} token
#
# @example
# token.set('...')
###
exports.set = (token) ->
	Promise.try ->
		return storage.setItem(TOKEN_KEY, token.trim())

###*
# @summary Get the token
# @function
# @public
#
# @description
# This function resolved to undefined if no token.
#
# @returns {Promise<String>} token
#
# @example
# token.get().then (sessionToken) ->
#		console.log(sessionToken)
###
exports.get = ->
	Promise.try ->
		return storage.getItem(TOKEN_KEY) or undefined

###*
# @summary Has a token
# @function
# @public
#
# @returns {Promise<Boolean>} has token
#
# @example
# token.has().then (hasToken) ->
#		if hasToken
#			console.log('There is a token!')
#		else
#			console.log('There is not a token!')
###
exports.has = ->
	exports.get().then (token) ->
		return token?

###*
# @summary Remove the token
# @function
# @public
#
# @description
# This promise is not rejected if there was no token at the time of removal.
#
# @example
# token.remove()
###
exports.remove = ->
	Promise.try ->
		return storage.removeItem(TOKEN_KEY)

###*
# @summary Parse a token
# @function
# @public
#
# @description
# This function does't save the token. Use `token.set()` if you want to persist it afterwards.
#
# @param {String} token - token
# @returns {Promise<Object>} parsed token
#
# @example
# token.parse('...').then (parsedToken) ->
#		console.log(parsedToken)
###
exports.parse = (token) ->
	Promise.try ->
		token = token.trim()

		try
			[ header, data, signature ] = token.split('.')
			return JSON.parse(atob(data))
		catch
			throw new errors.ResinMalformedToken(token)

###*
# @summary Get a property from a saved token
# @function
# @public
#
# @description
# This function resolves to undefined for any property name if there is no token.
# It also resolved to undefined if the property name is invalid.
#
# @param {String} property - property name
# @returns {Promise<*>} property value
#
# @example
# token.getProperty('username').then (username) ->
#		console.log(username)
###
exports.getProperty = (property) ->
	exports.has().then (hasToken) ->
		return if not hasToken
		exports.get().then(exports.parse).get(property)

###*
# @summary Get the username of the saved token
# @function
# @public
#
# @description
# This function resolves to undefined if there is no token
#
# @returns {Promise<String>} username
#
# @example
# token.getUsername().then (username) ->
#		console.log(username)
###
exports.getUsername = ->
	return exports.getProperty('username')

###*
# @summary Get the user id of the saved token
# @function
# @public
#
# @description
# This function resolves to undefined if there is no token
#
# @returns {Promise<Number>} user id
#
# @example
# token.getUserId().then (userId) ->
#		console.log(userId)
###
exports.getUserId = ->
	return exports.getProperty('id')
