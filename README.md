resin-token
-----------

[![npm version](https://badge.fury.io/js/resin-token.svg)](http://badge.fury.io/js/resin-token)
[![dependencies](https://david-dm.org/resin-io/resin-token.png)](https://david-dm.org/resin-io/resin-token.png)
[![Build Status](https://travis-ci.org/resin-io/resin-token.svg?branch=master)](https://travis-ci.org/resin-io/resin-token)
[![Build status](https://ci.appveyor.com/api/projects/status/i01h2qi3raf0acm7?svg=true)](https://ci.appveyor.com/project/jviotti/resin-token)

Join our online chat at [![Gitter chat](https://badges.gitter.im/resin-io/chat.png)](https://gitter.im/resin-io/chat)

Resin.io session token utilities.

Role
----

The intention of this module is to provide low level access to how a Resin.io session token is parsed and persisted.

**THIS MODULE IS LOW LEVEL AND IS NOT MEANT TO BE USED BY END USERS DIRECTLY**.

Unless you know what you're doing, use the [Resin SDK](https://github.com/resin-io/resin-sdk) instead.

Installation
------------

Install `resin-token` by running:

```sh
$ npm install --save resin-token
```

Documentation
-------------

The module returns a _factory function_ that you use to get an instance of the token module.

It accepts the following params:

| Param | Type | Description |
| --- | --- | --- |
| options | <code>Object</code> | options |
| options.dataDirectory | <code>string</code> | the directory to use for storage in Node.js. Ignored in the browser. |

**Example**
```js
const token = require('resin-token')({
	dataDirectory: '/opt/cache/resin'
})
```


* [token](#module_token)
    * [~parse(token)](#module_token..parse) ⇒ <code>Promise.&lt;Object&gt;</code>
    * [~isValid(token)](#module_token..isValid) ⇒ <code>Promise.&lt;Boolean&gt;</code>
    * [~isExpired()](#module_token..isExpired) ⇒ <code>Promise.&lt;boolean&gt;</code>
    * [~set(token)](#module_token..set) ⇒ <code>Promise.&lt;String&gt;</code>
    * [~get()](#module_token..get) ⇒ <code>Promise.&lt;String&gt;</code>
    * [~has()](#module_token..has) ⇒ <code>Promise.&lt;Boolean&gt;</code>
    * [~remove()](#module_token..remove) ⇒ <code>Promise</code>
    * [~getData()](#module_token..getData) ⇒ <code>Promise.&lt;Object&gt;</code>
    * [~getProperty(property)](#module_token..getProperty) ⇒ <code>Promise.&lt;\*&gt;</code>
    * [~getUsername()](#module_token..getUsername) ⇒ <code>Promise.&lt;String&gt;</code>
    * [~getUserId()](#module_token..getUserId) ⇒ <code>Promise.&lt;Number&gt;</code>
    * [~getEmail()](#module_token..getEmail) ⇒ <code>Promise.&lt;String&gt;</code>
    * [~getAge()](#module_token..getAge) ⇒ <code>Promise.&lt;Number&gt;</code>

<a name="module_token..parse"></a>

### token~parse(token) ⇒ <code>Promise.&lt;Object&gt;</code>
This function does't save the token. Use `token.set()` if you want to persist it afterwards.
The returned promise is rejected if the token is invalid.

**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Parse a token  
**Returns**: <code>Promise.&lt;Object&gt;</code> - parsed token  
**Access**: public  

| Param | Type | Description |
| --- | --- | --- |
| token | <code>String</code> | token |

**Example**  
```js
token.parse('...').then((parsedTokenData) => {
	console.log(parsedTokenData);
});
```
<a name="module_token..isValid"></a>

### token~isValid(token) ⇒ <code>Promise.&lt;Boolean&gt;</code>
**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Check if a token is valid  
**Returns**: <code>Promise.&lt;Boolean&gt;</code> - is valid  
**Access**: public  

| Param | Type | Description |
| --- | --- | --- |
| token | <code>String</code> | token |

**Example**  
```js
token.isValid('...').then((isValid) => {
	if (isValid) {
		console.log('The token is valid!');
	}
});
```
<a name="module_token..isExpired"></a>

### token~isExpired() ⇒ <code>Promise.&lt;boolean&gt;</code>
**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Check if the given token has expired  
**Access**: public  
**Example**  
```js
token.isExpired(jwtToken).then((isExpired) => {
	console.log(isExpired);
});
```
<a name="module_token..set"></a>

### token~set(token) ⇒ <code>Promise.&lt;String&gt;</code>
**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Set the token  
**Returns**: <code>Promise.&lt;String&gt;</code> - token  
**Access**: public  

| Param | Type | Description |
| --- | --- | --- |
| token | <code>String</code> | token |

**Example**  
```js
token.set('...');
```
<a name="module_token..get"></a>

### token~get() ⇒ <code>Promise.&lt;String&gt;</code>
This function resolved to undefined if no token.

**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Get the token  
**Returns**: <code>Promise.&lt;String&gt;</code> - token  
**Access**: public  
**Example**  
```js
token.get().then((sessionToken) => {
	console.log(sessionToken);
});
```
<a name="module_token..has"></a>

### token~has() ⇒ <code>Promise.&lt;Boolean&gt;</code>
**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Has a token  
**Returns**: <code>Promise.&lt;Boolean&gt;</code> - has token  
**Access**: public  
**Example**  
```js
token.has().then((hasToken) => {
	if (hasToken) {
		console.log('There is a token!');
	} else {
		console.log('There is not a token!');
	}
});
```
<a name="module_token..remove"></a>

### token~remove() ⇒ <code>Promise</code>
This promise is not rejected if there was no token at the time of removal.

**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Remove the token  
**Access**: public  
**Example**  
```js
token.remove();
```
<a name="module_token..getData"></a>

### token~getData() ⇒ <code>Promise.&lt;Object&gt;</code>
It will resolve to `undefined` if there's no saved token

**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Get the data encoded in the saved token  
**Returns**: <code>Promise.&lt;Object&gt;</code> - token data  
**Access**: public  
**Example**  
```js
token.getData().then((parsedTokenData) => {
	console.log(parsedTokenData);
});
```
<a name="module_token..getProperty"></a>

### token~getProperty(property) ⇒ <code>Promise.&lt;\*&gt;</code>
This function resolves to `undefined` for any property name if there is no token.
It also resolved to `undefined` if the property name is invalid.

**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Get a property from a saved token  
**Returns**: <code>Promise.&lt;\*&gt;</code> - property value  
**Access**: public  

| Param | Type | Description |
| --- | --- | --- |
| property | <code>String</code> | property name |

**Example**  
```js
token.getProperty('username').then((username) => {
	console.log(username);
});
```
<a name="module_token..getUsername"></a>

### token~getUsername() ⇒ <code>Promise.&lt;String&gt;</code>
This function resolves to `undefined` if there is no token

**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Get the username of the saved token  
**Returns**: <code>Promise.&lt;String&gt;</code> - username  
**Access**: public  
**Example**  
```js
token.getUsername().then((username) => {
	console.log(username);
});
```
<a name="module_token..getUserId"></a>

### token~getUserId() ⇒ <code>Promise.&lt;Number&gt;</code>
This function resolves to `undefined` if there is no token

**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Get the user id of the saved token  
**Returns**: <code>Promise.&lt;Number&gt;</code> - user id  
**Access**: public  
**Example**  
```js
token.getUserId().then((userId) => {
	console.log(userId);
});
```
<a name="module_token..getEmail"></a>

### token~getEmail() ⇒ <code>Promise.&lt;String&gt;</code>
This function resolves to `undefined` if there is no token

**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Get the email of the saved token  
**Returns**: <code>Promise.&lt;String&gt;</code> - email  
**Access**: public  
**Example**  
```js
token.getEmail().then((email) =>
	console.log(email);
});
```
<a name="module_token..getAge"></a>

### token~getAge() ⇒ <code>Promise.&lt;Number&gt;</code>
This function resolves to `undefined` if there is no token

**Kind**: inner method of [<code>token</code>](#module_token)  
**Summary**: Get the age of the saved token  
**Returns**: <code>Promise.&lt;Number&gt;</code> - age in milliseconds  
**Access**: public  
**Example**  
```js
token.getAge().then((age) => {
	console.log(age);
});
```

Support
-------

If you're having any problem, please [raise an issue](https://github.com/resin-io/resin-token/issues/new) on GitHub and the Resin.io team will be happy to help.

Tests
-----

Run the test suite by doing:

```sh
$ npm test
```

Contribute
----------

- Issue Tracker: [github.com/resin-io/resin-token/issues](https://github.com/resin-io/resin-token/issues)
- Source Code: [github.com/resin-io/resin-token](https://github.com/resin-io/resin-token)

Before submitting a PR, please make sure that you include tests, and that [coffeelint](http://www.coffeelint.org/) runs without any warning:

```sh
$ npm run lint
```

License
-------

The project is licensed under the Apache 2.0 license.
