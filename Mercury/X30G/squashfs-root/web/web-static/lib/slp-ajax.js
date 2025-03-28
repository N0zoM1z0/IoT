﻿(function(){
	// Used for splitting on whitespace
	var core_rnotwhite = /\S+/g;

	var
	// Document location
	ajaxLocParts,
	ajaxLocation,
	ajax_nonce = jQuery.now(),

	ajax_rquery = /\?/,
	rhash = /#.*$/,
	rts = /([?&])_=[^&]*/,
	rheaders = /^(.*?):[ \t]*([^\r\n]*)\r?$/mg, // IE leaves an \r character at EOL
	// #7653, #8125, #8152: local protocol detection
	rlocalProtocol = /^(?:about|app|app-storage|.+-extension|file|res|widget):$/,
	rnoContent = /^(?:GET|HEAD)$/,
	rprotocol = /^\/\//,
	rurl = /^([\w.+-]+:)(?:\/\/([^\/?#:]*)(?::(\d+)|)|)/,

	// Keep a copy of the old load method
	_load = jQuery.fn.load,

	/* Prefilters
	 * 1) They are useful to introduce custom dataTypes (see ajax/jsonp.js for an example)
	 * 2) These are called:
	 *    - BEFORE asking for a transport
	 *    - AFTER param serialization (s.data is a string if s.processData is true)
	 * 3) key is the dataType
	 * 4) the catchall symbol "*" can be used
	 * 5) execution will start with transport dataType and THEN continue down to "*" if needed
	 */
	prefilters = {},

	/* Transports bindings
	 * 1) key is the dataType
	 * 2) the catchall symbol "*" can be used
	 * 3) selection will start with transport dataType and THEN go to "*" if needed
	 */
	transports = {},

	// Avoid comment-prolog char sequence (#10098); must appease lint and evade compression
	allTypes = "*/".concat("*");

	// #8138, IE may throw an exception when accessing
	// a field from window.location if document.domain has been set
	try {
		ajaxLocation = location.href;
	} catch( e ) {
		// Use the href attribute of an A element
		// since IE will modify it given document.location
		ajaxLocation = document.createElement( "a" );
		ajaxLocation.href = "";
		ajaxLocation = ajaxLocation.href;
	}

	// Added by Song Kaiqiang, to make sure ajaxLocation only includes
	// domain and port information, mainly adapt tile_1.0 APP
	//ajaxLocation = rurl.exec( ajaxLocation )[0];

	// Segment location into parts
	ajaxLocParts = rurl.exec( ajaxLocation.toLowerCase() ) || [];

	function getHandleCode(text)
	{
		var handleCode, data, obj;
		try {
			obj = JSON.parse(text);
		} catch(e) {
			obj = null;
		}

		if (obj == null)
		{
			handleCode = 0;
		}
		else
		{
			handleCode = obj[ERR_CODE];
		}

		return handleCode;
	}

	// Base "constructor" for jQuery.ajaxPrefilter and jQuery.ajaxTransport
	function addToPrefiltersOrTransports( structure ) {

		// dataTypeExpression is optional and defaults to "*"
		return function( dataTypeExpression, func ) {

			if ( typeof dataTypeExpression !== "string" ) {
				func = dataTypeExpression;
				dataTypeExpression = "*";
			}

			var dataType,
				i = 0,
				dataTypes = dataTypeExpression.toLowerCase().match( core_rnotwhite ) || [];

			if ( jQuery.isFunction( func ) ) {
				// For each dataType in the dataTypeExpression
				while ( (dataType = dataTypes[i++]) ) {
					// Prepend if requested
					if ( dataType[0] === "+" ) {
						dataType = dataType.slice( 1 ) || "*";
						(structure[ dataType ] = structure[ dataType ] || []).unshift( func );

					// Otherwise append
					} else {
						(structure[ dataType ] = structure[ dataType ] || []).push( func );
					}
				}
			}
		};
	}

	// Base inspection function for prefilters and transports
	function inspectPrefiltersOrTransports( structure, options, originalOptions, jqXHR ) {

		var inspected = {},
			seekingTransport = ( structure === transports );

		function inspect( dataType ) {
			var selected;
			inspected[ dataType ] = true;
			jQuery.each( structure[ dataType ] || [], function( _, prefilterOrFactory ) {
				var dataTypeOrTransport = prefilterOrFactory( options, originalOptions, jqXHR );
				if( typeof dataTypeOrTransport === "string" && !seekingTransport && !inspected[ dataTypeOrTransport ] ) {
					options.dataTypes.unshift( dataTypeOrTransport );
					inspect( dataTypeOrTransport );
					return false;
				} else if ( seekingTransport ) {
					return !( selected = dataTypeOrTransport );
				}
			});
			return selected;
		}

		return inspect( options.dataTypes[ 0 ] ) || !inspected[ "*" ] && inspect( "*" );
	}

	// A special extend for ajax options
	// that takes "flat" options (not to be deep extended)
	// Fixes #9887
	function ajaxExtend( target, src ) {
		var deep, key,
			flatOptions = jQuery.ajaxSettings.flatOptions || {};

		for ( key in src ) {
			if ( src[ key ] !== undefined ) {
				( flatOptions[ key ] ? target : ( deep || (deep = {}) ) )[ key ] = src[ key ];
			}
		}
		if ( deep ) {
			jQuery.extend( true, target, deep );
		}

		return target;
	}

	jQuery.fn.load = function( url, params, callback ) {
		if ( typeof url !== "string" && _load ) {
			return _load.apply( this, arguments );
		}

		var selector, response, type,
			self = this,
			off = url.indexOf(" ");

		if ( off >= 0 ) {
			selector = url.slice( off, url.length );
			url = url.slice( 0, off );
		}

		// If it's a function
		if ( jQuery.isFunction( params ) ) {

			// We assume that it's the callback
			callback = params;
			params = undefined;

		// Otherwise, build a param string
		} else if ( params && typeof params === "object" ) {
			type = "POST";
		}

		// If we have elements to modify, make the request
		if ( self.length > 0 ) {
			jQuery.ajax({
				url: url,

				// if "type" variable is undefined, then "GET" method will be used
				type: type,
				dataType: "html",
				data: params
			}).done(function( responseText ) {

				// Save response for use in complete callback
				response = arguments;

				self.html( selector ?

					// If a selector was specified, locate the right elements in a dummy div
					// Exclude scripts to avoid IE 'Permission Denied' errors
					jQuery("<div>").append( jQuery.parseHTML( responseText ) ).find( selector ) :

					// Otherwise use the full result
					responseText );

			}).complete( callback && function( jqXHR, status ) {
				self.each( callback, response || [ jqXHR.responseText, status, jqXHR ] );
			});
		}

		return this;
	};

	// Attach a bunch of functions for handling common AJAX events
	jQuery.each( [ "ajaxStart", "ajaxStop", "ajaxComplete", "ajaxError", "ajaxSuccess", "ajaxSend" ], function( i, type ){
		jQuery.fn[ type ] = function( fn ){
			return this.on( type, fn );
		};
	});

	jQuery.each( [ "get", "post" ], function( i, method ) {
		jQuery[ method ] = function( url, data, callback, type ) {
			// shift arguments if data argument was omitted
			if ( jQuery.isFunction( data ) ) {
				type = type || callback;
				callback = data;
				data = undefined;
			}

			return jQuery.ajax({
				url: url,
				type: method,
				dataType: type,
				data: data,
				success: callback
			});
		};
	});

	jQuery.extend({
		slpParseJSON : function(data, s)
		{
			// Attempt to parse using the native JSON parser first
			if ( window.JSON && window.JSON.parse ) {
				if (s.utf8Encode) {
					return window.JSON.parse(data,
						function(k, v){
							var val = v;

							if (typeof val === "string")
							{
								try
								{
									val = decodeURIComponent(val);
								}catch(ex){}
							}

							return val;
						}
					);
				}
				else {
					return window.JSON.parse(data);
				}
			}

			if ( data === null ) {
				return data;
			}

			if ( typeof data === "string" ) {

				// Make sure leading/trailing whitespace is removed (IE can't handle it)
				data = jQuery.trim( data );

				if ( data ) {
					// Make sure the incoming data is actual JSON
					// Logic borrowed from http://json.org/json2.js
					if ( rvalidchars.test( data.replace( rvalidescape, "@" )
						.replace( rvalidtokens, "]" )
						.replace( rvalidbraces, "")) ) {

						return ( new Function( "return " + data ) )();
					}
				}
			}

			jQuery.error( "Invalid JSON: " + data );
		}
	});

	jQuery.extend({

		// Counter for holding the number of active queries
		active: 0,

		// Last-Modified header cache for next request
		lastModified: {},
		etag: {},

		ajaxSettings: {
			url: ajaxLocation,
			type: "GET",
			isLocal: rlocalProtocol.test( ajaxLocParts[ 1 ] ),
			global: true,
			processData: true,
			async: true,
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			/*
			timeout: 0,
			data: null,
			dataType: null,
			username: null,
			password: null,
			cache: null,
			throws: false,
			traditional: false,
			headers: {},
			*/

			accepts: {
				"*": allTypes,
				text: "text/plain",
				html: "text/html",
				xml: "application/xml, text/xml",
				json: "application/json, text/javascript"
			},

			contents: {
				xml: /xml/,
				html: /html/,
				json: /json/
			},

			responseFields: {
				xml: "responseXML",
				text: "responseText"
			},

			// Data converters
			// Keys separate source (or catchall "*") and destination types with a single space
			converters: {

				// Convert anything to text
				"* text": window.String,

				// Text to html (true = no transformation)
				"text html": true,

				// Evaluate text as a json expression
				"text json": jQuery.slpParseJSON,

				// Parse text as xml
				"text xml": jQuery.parseXML
			},

			// For options that shouldn't be deep extended:
			// you can add your own custom options here if
			// and when you create one that shouldn't be
			// deep extended (see ajaxExtend)
			flatOptions: {
				url: true,
				context: true
			}
		},

		// Creates a full fledged settings object into target
		// with both ajaxSettings and settings fields.
		// If target is omitted, writes into ajaxSettings.
		ajaxSetup: function( target, settings ) {
			return settings ?

				// Building a settings object
				ajaxExtend( ajaxExtend( target, jQuery.ajaxSettings ), settings ) :

				// Extending ajaxSettings
				ajaxExtend( jQuery.ajaxSettings, target );
		},

		ajaxPrefilter: addToPrefiltersOrTransports( prefilters ),
		ajaxTransport: addToPrefiltersOrTransports( transports ),

		// Main method
		ajax: function( url, options ) {
			// If url is an object, simulate pre-1.5 signature
			if ( typeof url === "object" ) {
				options = url;
				url = undefined;
			}

			// Force options to be an object
			options = options || {};

			var // Cross-domain detection vars
				parts,
				// Loop variable
				i,
				// URL without anti-cache param
				cacheURL,
				// Response headers as string
				responseHeadersString,
				// timeout handle
				timeoutTimer,

				// To know if global events are to be dispatched
				fireGlobals,

				transport,
				// Response headers
				responseHeaders,
				// Create the final options object
				s = jQuery.ajaxSetup( {}, options ),
				// Callbacks context
				callbackContext = s.context || s,
				// Context for global events is callbackContext if it is a DOM node or jQuery collection
				globalEventContext = s.context && ( callbackContext.nodeType || callbackContext.jquery ) ?
					jQuery( callbackContext ) :
					jQuery.event,
				// Deferreds
				deferred = jQuery.Deferred(),
				completeDeferred = jQuery.Callbacks("once memory"),
				// Status-dependent callbacks
				statusCode = s.statusCode || {},
				// Headers (they are sent all at once)
				requestHeaders = {},
				requestHeadersNames = {},
				// The jqXHR state
				state = 0,
				// Default abort message
				strAbort = "canceled",
				// Fake xhr
				jqXHR = {
					readyState: 0,

					// Builds headers hashtable if needed
					getResponseHeader: function( key ) {
						var match;
						if ( state === 2 ) {
							if ( !responseHeaders ) {
								responseHeaders = {};
								while ( (match = rheaders.exec( responseHeadersString )) ) {
									responseHeaders[ match[1].toLowerCase() ] = match[ 2 ];
								}
							}
							match = responseHeaders[ key.toLowerCase() ];
						}
						return match == null ? null : match;
					},

					// Raw string
					getAllResponseHeaders: function() {
						return state === 2 ? responseHeadersString : null;
					},

					// Caches the header
					setRequestHeader: function( name, value ) {
						var lname = name.toLowerCase();
						if ( !state ) {
							name = requestHeadersNames[ lname ] = requestHeadersNames[ lname ] || name;
							requestHeaders[ name ] = value;
						}
						return this;
					},

					// Overrides response content-type header
					overrideMimeType: function( type ) {
						if ( !state ) {
							s.mimeType = type;
						}
						return this;
					},

					// Status-dependent callbacks
					statusCode: function( map ) {
						var code;
						if ( map ) {
							if ( state < 2 ) {
								for ( code in map ) {
									// Lazy-add the new callback in a way that preserves old ones
									statusCode[ code ] = [ statusCode[ code ], map[ code ] ];
								}
							} else {
								// Execute the appropriate callbacks
								jqXHR.always( map[ jqXHR.status ] );
							}
						}
						return this;
					},

					// Cancel the request
					abort: function( statusText ) {
						var finalText = statusText || strAbort;
						if ( transport ) {
							transport.abort( finalText );
						}
						done( 0, finalText );
						return this;
					}
				};

			// Attach deferreds
			deferred.promise( jqXHR ).complete = completeDeferred.add;
			jqXHR.success = jqXHR.done;
			jqXHR.error = jqXHR.fail;

			// Remove hash character (#7531: and string promotion)
			// Add protocol if not provided (#5866: IE7 issue with protocol-less urls)
			// Handle falsy url in the settings object (#10093: consistency with old signature)
			// We also use the url parameter if available
			s.url = ( ( url || s.url || ajaxLocation ) + "" ).replace( rhash, "" ).replace( rprotocol, ajaxLocParts[ 1 ] + "//" );

			// Alias method option to type as per ticket #12004
			s.type = options.method || options.type || s.method || s.type;

			// Extract dataTypes list
			s.dataTypes = jQuery.trim( s.dataType || "*" ).toLowerCase().match( core_rnotwhite ) || [""];

			// A cross-domain request is in order when we have a protocol:host:port mismatch
			if ( s.crossDomain == null ) {
				parts = rurl.exec( s.url.toLowerCase() );
				s.crossDomain = !!( parts &&
					( parts[ 1 ] !== ajaxLocParts[ 1 ] || parts[ 2 ] !== ajaxLocParts[ 2 ] ||
						( parts[ 3 ] || ( parts[ 1 ] === "http:" ? 80 : 443 ) ) !=
							( ajaxLocParts[ 3 ] || ( ajaxLocParts[ 1 ] === "http:" ? 80 : 443 ) ) )
				);
			}

			// added by WuWeier, convert data to JSON string.
			if (s.data && s.processData && s.postDataType == "json" && typeof s.data !== "string") {
				if (s.utf8Encode) {
					s.data = JSON.stringify(
						s.data,
						function(key, value) {
							if (typeof(value) === "string") {
								return encodeURIComponent(value);
							}
							return value;
						}
					);
				}
				else {
					s.data = JSON.stringify(s.data);
				}
			}
			// Convert data if not already a string
			else if ( s.data && s.processData && typeof s.data !== "string" ) {
				s.data = jQuery.param( s.data, s.traditional );
			}

			// Apply prefilters
			inspectPrefiltersOrTransports( prefilters, s, options, jqXHR );

			// If request was aborted inside a prefilter, stop there
			if ( state === 2 ) {
				return jqXHR;
			}

			// We can fire global events as of now if asked to
			fireGlobals = s.global;

			// Watch for a new set of requests
			if ( fireGlobals && jQuery.active++ === 0 ) {
				jQuery.event.trigger("ajaxStart");
			}

			// Uppercase the type
			s.type = s.type.toUpperCase();

			// Determine if request has content
			s.hasContent = !rnoContent.test( s.type );

			// Save the URL in case we're toying with the If-Modified-Since
			// and/or If-None-Match header later on
			cacheURL = s.url;

			// More options handling for requests with no content
			if ( !s.hasContent ) {

				// If data is available, append data to url
				if ( s.data ) {
					cacheURL = ( s.url += ( ajax_rquery.test( cacheURL ) ? "&" : "?" ) + s.data );
					// #9682: remove data so that it's not used in an eventual retry
					delete s.data;
				}

				// Add anti-cache in url if needed
				if ( s.cache === false ) {
					s.url = rts.test( cacheURL ) ?

						// If there is already a '_' parameter, set its value
						cacheURL.replace( rts, "$1_=" + ajax_nonce++ ) :

						// Otherwise add one to the end
						cacheURL + ( ajax_rquery.test( cacheURL ) ? "&" : "?" ) + "_=" + ajax_nonce++;
				}
			}

			// Set the If-Modified-Since and/or If-None-Match header, if in ifModified mode.
			if ( s.ifModified ) {
				if ( jQuery.lastModified[ cacheURL ] ) {
					jqXHR.setRequestHeader( "If-Modified-Since", jQuery.lastModified[ cacheURL ] );
				}
				if ( jQuery.etag[ cacheURL ] ) {
					jqXHR.setRequestHeader( "If-None-Match", jQuery.etag[ cacheURL ] );
				}
			}

			// Set the correct header, if data is being sent
			if ( s.data && s.hasContent && s.contentType !== false || options.contentType ) {
				jqXHR.setRequestHeader( "Content-Type", s.contentType );
			}

			// Set the Accepts header for the server, depending on the dataType
			jqXHR.setRequestHeader(
				"Accept",
				s.dataTypes[ 0 ] && s.accepts[ s.dataTypes[0] ] ?
					s.accepts[ s.dataTypes[0] ] + ( s.dataTypes[ 0 ] !== "*" ? ", " + allTypes + "; q=0.01" : "" ) :
					s.accepts[ "*" ]
			);

			// Check for headers option
			for ( i in s.headers ) {
				jqXHR.setRequestHeader( i, s.headers[ i ] );
			}

			// Allow custom headers/mimetypes and early abort
			if ( s.beforeSend && ( s.beforeSend.call( callbackContext, jqXHR, s ) === false || state === 2 ) ) {
				// Abort if not done already and return
				return jqXHR.abort();
			}

			// aborting is no longer a cancellation
			strAbort = "abort";

			// Install callbacks on deferreds
			for ( i in { success: 1, error: 1, complete: 1 } ) {
				jqXHR[ i ]( s[ i ] );
			}

			// Get transport
			transport = inspectPrefiltersOrTransports( transports, s, options, jqXHR );

			// If no transport, we auto-abort
			if ( !transport ) {
				done( -1, "No Transport" );
			} else {
				jqXHR.readyState = 1;

				// Send global event
				if ( fireGlobals ) {
					globalEventContext.trigger( "ajaxSend", [ jqXHR, s ] );
				}
				// Timeout
				if ( s.async && s.timeout > 0 ) {
					timeoutTimer = setTimeout(function() {
						jqXHR.abort("timeout");
					}, s.timeout );
				}

				try {
					state = 1;
					transport.send( requestHeaders, done );
				} catch ( e ) {
					// Propagate exception as error if not done
					if ( state < 2 ) {
						done( -1, e );
					// Simply rethrow otherwise
					} else {
						throw e;
					}
				}
			}

			// Callback for when everything is done
			function done( status, nativeStatusText, responses, headers ) {
				var isSuccess, success, error, response, modified,
					statusText = nativeStatusText;

				// Called once
				if ( state === 2 ) {
					return;
				}

				// State is "done" now
				state = 2;

				// Clear timeout if it exists
				if ( timeoutTimer ) {
					clearTimeout( timeoutTimer );
				}

				// Dereference transport for early garbage collection
				// (no matter how long the jqXHR object will be used)
				transport = undefined;

				// Cache response headers
				responseHeadersString = headers || "";

				// Set readyState
				jqXHR.readyState = status > 0 ? 4 : 0;

				// Get response data
				if ( responses ) {
					response = ajaxHandleResponses( s, jqXHR, responses );
				}

				// If successful, handle type chaining
				// changed by zsy of status == 401
				if ( status >= 200 && status < 300 || status === 304 || status === 401 ) {

					// Set the If-Modified-Since and/or If-None-Match header, if in ifModified mode.
					if ( s.ifModified ) {
						modified = jqXHR.getResponseHeader("Last-Modified");
						if ( modified ) {
							jQuery.lastModified[ cacheURL ] = modified;
						}
						modified = jqXHR.getResponseHeader("etag");
						if ( modified ) {
							jQuery.etag[ cacheURL ] = modified;
						}
					}

					// if no content
					if ( status === 204 ) {
						isSuccess = true;
						statusText = "nocontent";

					// if not modified
					} else if ( status === 304 ) {
						isSuccess = true;
						statusText = "notmodified";

					// If we have data, let's convert it
					} else {
						/*var code = getHandleCode(response);
						if (code == EUNAUTH) {
							showLogin(true);
							return;
						}*/

						isSuccess = ajaxConvert( s, response );
						statusText = isSuccess.state;
						success = isSuccess.data;
						error = isSuccess.error;
						isSuccess = !error;

					}
				} else {
					// We extract error from statusText
					// then normalize statusText and status for non-aborts
					error = statusText;
					if ( status || !statusText ) {
						statusText = "error";
						if ( status < 0 ) {
							status = 0;
						}
					}
				}

				// Set data for the fake xhr object
				jqXHR.status = status;
				jqXHR.statusText = ( nativeStatusText || statusText ) + "";

				// Success/Error
				if ( isSuccess ) {
					deferred.resolveWith( callbackContext, [ success, statusText, jqXHR ] );
				} else {
					deferred.rejectWith( callbackContext, [ jqXHR, statusText, error ] );
				}

				// Status-dependent callbacks
				jqXHR.statusCode( statusCode );
				statusCode = undefined;

				if ( fireGlobals ) {
					globalEventContext.trigger( isSuccess ? "ajaxSuccess" : "ajaxError",
						[ jqXHR, s, isSuccess ? success : error ] );
				}

				// Complete
				completeDeferred.fireWith( callbackContext, [ jqXHR, statusText ] );

				if ( fireGlobals ) {
					globalEventContext.trigger( "ajaxComplete", [ jqXHR, s ] );
					// Handle the global AJAX counter
					if ( !( --jQuery.active ) ) {
						jQuery.event.trigger("ajaxStop");
					}
				}
			}

			return jqXHR;
		},

		getScript: function( url, callback ) {
			return jQuery.get( url, undefined, callback, "script" );
		},

		getJSON: function( url, data, callback ) {
			return jQuery.get( url, data, callback, "json" );
		}
	});

	/* Handles responses to an ajax request:
	 * - sets all responseXXX fields accordingly
	 * - finds the right dataType (mediates between content-type and expected dataType)
	 * - returns the corresponding response
	 */
	function ajaxHandleResponses( s, jqXHR, responses ) {
		var firstDataType, ct, finalDataType, type,
			contents = s.contents,
			dataTypes = s.dataTypes,
			responseFields = s.responseFields;

		// Fill responseXXX fields
		for ( type in responseFields ) {
			if ( type in responses ) {
				jqXHR[ responseFields[type] ] = responses[ type ];
			}
		}

		// Remove auto dataType and get content-type in the process
		while( dataTypes[ 0 ] === "*" ) {
			dataTypes.shift();
			if ( ct === undefined ) {
				ct = s.mimeType || jqXHR.getResponseHeader("Content-Type");
			}
		}

		// Check if we're dealing with a known content-type
		if ( ct ) {
			for ( type in contents ) {
				if ( contents[ type ] && contents[ type ].test( ct ) ) {
					dataTypes.unshift( type );
					break;
				}
			}
		}

		// Check to see if we have a response for the expected dataType
		if ( dataTypes[ 0 ] in responses ) {
			finalDataType = dataTypes[ 0 ];
		} else {
			// Try convertible dataTypes
			for ( type in responses ) {
				if ( !dataTypes[ 0 ] || s.converters[ type + " " + dataTypes[0] ] ) {
					finalDataType = type;
					break;
				}
				if ( !firstDataType ) {
					firstDataType = type;
				}
			}
			// Or just use first one
			finalDataType = finalDataType || firstDataType;
		}

		// If we found a dataType
		// We add the dataType to the list if needed
		// and return the corresponding response
		if ( finalDataType ) {
			if ( finalDataType !== dataTypes[ 0 ] ) {
				dataTypes.unshift( finalDataType );
			}
			return responses[ finalDataType ];
		}
	}

	// Chain conversions given the request and the original response
	function ajaxConvert( s, response ) {
		var conv2, current, conv, tmp,
			converters = {},
			i = 0,
			// Work with a copy of dataTypes in case we need to modify it for conversion
			dataTypes = s.dataTypes.slice(),
			prev = dataTypes[ 0 ];

		// Apply the dataFilter if provided
		if ( s.dataFilter ) {
			response = s.dataFilter( response, s.dataType );
		}

		// Create converters map with lowercased keys
		if ( dataTypes[ 1 ] ) {
			for ( conv in s.converters ) {
				converters[ conv.toLowerCase() ] = s.converters[ conv ];
			}
		}

		// Convert to each sequential dataType, tolerating list modification
		for ( ; (current = dataTypes[++i]); ) {

			// There's only work to do if current dataType is non-auto
			if ( current !== "*" ) {

				// Convert response if prev dataType is non-auto and differs from current
				if ( prev !== "*" && prev !== current ) {

					// Seek a direct converter
					conv = converters[ prev + " " + current ] || converters[ "* " + current ];

					// If none found, seek a pair
					if ( !conv ) {
						for ( conv2 in converters ) {

							// If conv2 outputs current
							tmp = conv2.split(" ");
							if ( tmp[ 1 ] === current ) {

								// If prev can be converted to accepted input
								conv = converters[ prev + " " + tmp[ 0 ] ] ||
									converters[ "* " + tmp[ 0 ] ];
								if ( conv ) {
									// Condense equivalence converters
									if ( conv === true ) {
										conv = converters[ conv2 ];

									// Otherwise, insert the intermediate dataType
									} else if ( converters[ conv2 ] !== true ) {
										current = tmp[ 0 ];
										dataTypes.splice( i--, 0, current );
									}

									break;
								}
							}
						}
					}

					// Apply converter (if not an equivalence)
					if ( conv !== true ) {

						// Unless errors are allowed to bubble, catch and return them
						if ( conv && s["throws"] ) {
							response = conv( response, s );
						} else {
							try {
								response = conv( response, s );
							} catch ( e ) {
								return { state: "parsererror", error: conv ? e : "No conversion from " + prev + " to " + current };
							}
						}
					}
				}

				// Update prev for next iteration
				prev = current;
			}
		}

		return { state: "success", data: response };
	}
	// Install script dataType
	jQuery.ajaxSetup({
		accepts: {
			script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"
		},
		contents: {
			script: /(?:java|ecma)script/
		},
		converters: {
			"text script": function( text ) {
				jQuery.globalEval( text );
				return text;
			}
		}
	});

	// Handle cache's special case and global
	jQuery.ajaxPrefilter( "script", function( s ) {
		if ( s.cache === undefined ) {
			s.cache = false;
		}
		if ( s.crossDomain ) {
			s.type = "GET";
			s.global = false;
		}
	});

	// Bind script tag hack transport
	jQuery.ajaxTransport( "script", function(s) {

		// This transport only deals with cross domain requests
		if ( s.crossDomain ) {

			var script,
				head = document.head || jQuery("head")[0] || document.documentElement;

			return {

				send: function( _, callback ) {

					script = document.createElement("script");

					script.async = true;

					if ( s.scriptCharset ) {
						script.charset = s.scriptCharset;
					}

					script.src = s.url;

					// Attach handlers for all browsers
					script.onload = script.onreadystatechange = function( _, isAbort ) {

						if ( isAbort || !script.readyState || /loaded|complete/.test( script.readyState ) ) {

							// Handle memory leak in IE
							script.onload = script.onreadystatechange = null;

							// Remove the script
							if ( script.parentNode ) {
								script.parentNode.removeChild( script );
							}

							// Dereference the script
							script = null;

							// Callback if not abort
							if ( !isAbort ) {
								callback( 200, "success" );
							}
						}
					};

					// Circumvent IE6 bugs with base elements (#2709 and #4378) by prepending
					// Use native DOM manipulation to avoid our domManip AJAX trickery
					head.insertBefore( script, head.firstChild );
				},

				abort: function() {
					if ( script ) {
						script.onload( undefined, true );
					}
				}
			};
		}
	});
	var oldCallbacks = [],
		rjsonp = /(=)\?(?=&|$)|\?\?/;

	// Default jsonp settings
	jQuery.ajaxSetup({
		jsonp: "callback",
		jsonpCallback: function() {
			var callback = oldCallbacks.pop() || ( jQuery.expando + "_" + ( ajax_nonce++ ) );
			this[ callback ] = true;
			return callback;
		}
	});

	// Detect, normalize options and install callbacks for jsonp requests
	jQuery.ajaxPrefilter( "json jsonp", function( s, originalSettings, jqXHR ) {

		var callbackName, overwritten, responseContainer,
			jsonProp = s.jsonp !== false && ( rjsonp.test( s.url ) ?
				"url" :
				typeof s.data === "string" && !( s.contentType || "" ).indexOf("application/x-www-form-urlencoded") && rjsonp.test( s.data ) && "data"
			);

		// Handle iff the expected data type is "jsonp" or we have a parameter to set
		if ( jsonProp || s.dataTypes[ 0 ] === "jsonp" ) {

			// Get callback name, remembering preexisting value associated with it
			callbackName = s.jsonpCallback = jQuery.isFunction( s.jsonpCallback ) ?
				s.jsonpCallback() :
				s.jsonpCallback;

			// Insert callback into url or form data
			if ( jsonProp ) {
				s[ jsonProp ] = s[ jsonProp ].replace( rjsonp, "$1" + callbackName );
			} else if ( s.jsonp !== false ) {
				s.url += ( ajax_rquery.test( s.url ) ? "&" : "?" ) + s.jsonp + "=" + callbackName;
			}

			// Use data converter to retrieve json after script execution
			s.converters["script json"] = function() {
				if ( !responseContainer ) {
					jQuery.error( callbackName + " was not called" );
				}
				return responseContainer[ 0 ];
			};

			// force json dataType
			s.dataTypes[ 0 ] = "json";

			// Install callback
			overwritten = window[ callbackName ];
			window[ callbackName ] = function() {
				responseContainer = arguments;
			};

			// Clean-up function (fires after converters)
			jqXHR.always(function() {
				// Restore preexisting value
				window[ callbackName ] = overwritten;

				// Save back as free
				if ( s[ callbackName ] ) {
					// make sure that re-using the options doesn't screw things around
					s.jsonpCallback = originalSettings.jsonpCallback;

					// save the callback name for future use
					oldCallbacks.push( callbackName );
				}

				// Call if it was a function and we have a response
				if ( responseContainer && jQuery.isFunction( overwritten ) ) {
					overwritten( responseContainer[ 0 ] );
				}

				responseContainer = overwritten = undefined;
			});

			// Delegate to script
			return "script";
		}
	});
	var xhrCallbacks, xhrSupported,
		xhrId = 0,
		// #5280: Internet Explorer will keep connections alive if we don't abort on unload
		xhrOnUnloadAbort = window.ActiveXObject && function() {
			// Abort all pending requests
			var key;
			for ( key in xhrCallbacks ) {
				xhrCallbacks[ key ]( undefined, true );
			}
		};

	// Functions to create xhrs
	function createStandardXHR() {
		try {
			return new window.XMLHttpRequest();
		} catch( e ) {}
	}

	function createActiveXHR() {
		try {
			return new window.ActiveXObject("Microsoft.XMLHTTP");
		} catch( e ) {}
	}

	// Create the request object
	// (This is still attached to ajaxSettings for backward compatibility)
	jQuery.ajaxSettings.xhr = window.ActiveXObject ?
		/* Microsoft failed to properly
		 * implement the XMLHttpRequest in IE7 (can't request local files),
		 * so we use the ActiveXObject when it is available
		 * Additionally XMLHttpRequest can be disabled in IE7/IE8 so
		 * we need a fallback.
		 */
		function() {
			return !this.isLocal && createStandardXHR() || createActiveXHR();
		} :
		// For all other browsers, use the standard XMLHttpRequest object
		createStandardXHR;

	// Determine support properties
	xhrSupported = jQuery.ajaxSettings.xhr();
	jQuery.support.cors = !!xhrSupported && ( "withCredentials" in xhrSupported );
	xhrSupported = jQuery.support.ajax = !!xhrSupported;

	// Create transport if the browser can provide an xhr
	if ( xhrSupported ) {

		jQuery.ajaxTransport(function( s ) {
			// Cross domain only allowed if supported through XMLHttpRequest
			if ( !s.crossDomain || jQuery.support.cors ) {

				var callback;

				return {
					send: function( headers, complete ) {

						// Get a new xhr
						var handle, i,
							xhr = s.xhr();

						// Open the socket
						// Passing null username, generates a login popup on Opera (#2865)
						if ( s.username ) {
							xhr.open( s.type, s.url, s.async, s.username, s.password );
						} else {
							xhr.open( s.type, s.url, s.async );
						}

						// Apply custom fields if provided
						if ( s.xhrFields ) {
							for ( i in s.xhrFields ) {
								xhr[ i ] = s.xhrFields[ i ];
							}
						}

						// Override mime type if needed
						if ( s.mimeType && xhr.overrideMimeType ) {
							xhr.overrideMimeType( s.mimeType );
						}

						// X-Requested-With header
						// For cross-domain requests, seeing as conditions for a preflight are
						// akin to a jigsaw puzzle, we simply never set it to be sure.
						// (it can always be set on a per-request basis or even using ajaxSetup)
						// For same-domain requests, won't change header if already provided.
						if ( !s.crossDomain && !headers["X-Requested-With"] ) {
							headers["X-Requested-With"] = "XMLHttpRequest";
						}

						// Need an extra try/catch for cross domain requests in Firefox 3
						try {
							for ( i in headers ) {
								xhr.setRequestHeader( i, headers[ i ] );
							}
						} catch( err ) {}

						// Do send the request
						// This may raise an exception which is actually
						// handled in jQuery.ajax (so no try/catch here)
						xhr.send( ( s.hasContent && s.data ) || null );

						// Listener
						callback = function( _, isAbort ) {
							var status, responseHeaders, statusText, responses;

							// Firefox throws exceptions when accessing properties
							// of an xhr when a network error occurred
							// http://helpful.knobs-dials.com/index.php/Component_returned_failure_code:_0x80040111_(NS_ERROR_NOT_AVAILABLE)
							try {

								// Was never called and is aborted or complete
								if ( callback && ( isAbort || xhr.readyState === 4 ) ) {

									// Only called once
									callback = undefined;

									// Do not keep as active anymore
									if ( handle ) {
										xhr.onreadystatechange = jQuery.noop;
										if ( xhrOnUnloadAbort ) {
											delete xhrCallbacks[ handle ];
										}
									}

									// If it's an abort
									if ( isAbort ) {
										// Abort it manually if needed
										if ( xhr.readyState !== 4 ) {
											xhr.abort();
										}
									} else {
										responses = {};
										status = xhr.status;
										responseHeaders = xhr.getAllResponseHeaders();

										// When requesting binary data, IE6-9 will throw an exception
										// on any attempt to access responseText (#11426)
										if ( typeof xhr.responseText === "string" ) {
											responses.text = xhr.responseText;
										}

										// Firefox throws an exception when accessing
										// statusText for faulty cross-domain requests
										try {
											statusText = xhr.statusText;
										} catch( e ) {
											// We normalize with Webkit giving an empty statusText
											statusText = "";
										}

										// Filter status for non standard behaviors

										// If the request is local and we have data: assume a success
										// (success with no data won't get notified, that's the best we
										// can do given current implementations)
										if ( !status && s.isLocal && !s.crossDomain ) {
											status = responses.text ? 200 : 404;
										// IE - #1450: sometimes returns 1223 when it should be 204
										} else if ( status === 1223 ) {
											status = 204;
										}
									}
								}
							} catch( firefoxAccessException ) {
								if ( !isAbort ) {
									complete( -1, firefoxAccessException );
								}
							}

							// Call complete if needed
							if ( responses ) {
								complete( status, statusText, responses, responseHeaders );
							}
						};

						if ( !s.async ) {
							// if we're in sync mode we fire the callback
							callback();
						} else if ( xhr.readyState === 4 ) {
							// (IE6 & IE7) if it's in cache and has been
							// retrieved directly we need to fire the callback
							setTimeout( callback );
						} else {
							handle = ++xhrId;
							if ( xhrOnUnloadAbort ) {
								// Create the active xhrs callbacks list if needed
								// and attach the unload handler
								if ( !xhrCallbacks ) {
									xhrCallbacks = {};
									jQuery( window ).unload( xhrOnUnloadAbort );
								}
								// Add to list of active xhrs callbacks
								xhrCallbacks[ handle ] = callback;
							}
							xhr.onreadystatechange = callback;
						}
					},

					abort: function() {
						if ( callback ) {
							callback( undefined, true );
						}
					}
				};
			}
		});
	}

	jQuery.extend({
		/* 替换JSON中的名字 */
		replaceObjName: function(str)
		{
			var matches = null, strRepace;
			var tempStr, result = "";
			var tagL = "\"", tagR = "\":";
			var rp = /\"(\w+)(\.(\w+)(\.(\w+))?)?\"\:/i;

			matches = rp.exec(str);
			try
			{
				while(matches != null)
				{
					tempStr = matches[1];
					if (undefined != matches[2])
					{
						tempStr += ("." + matches[3]);
						if (undefined != matches[4])
						{
							tempStr += ("." + matches[5]);
						}
					}

					try
					{
						strRepace = eval("(" + tempStr + ")");
						if (0 == strRepace.length)
						{
							strRepace = tempStr;
						}
						str = str.replace(tempStr, strRepace);
						result += str.substring(0, str.indexOf(strRepace) + strRepace.length + 2);
						str = str.substring(str.indexOf(strRepace) + strRepace.length + 2);
					}catch(ex)
					{
						result += str.substring(0, str.indexOf(tempStr) + tempStr.length + 2);
						str = str.substring(str.indexOf(tempStr) + tempStr.length + 2);
					}
					matches = rp.exec(str);
				}

				result += str;
			}catch(ex){}

			return result;
		}
	});

	jQuery.extend({
		/* 发送Ajax请求 */
		sendAjaxReq: function(url, data, callback, async, postDataType, utf8Encode, noShowLoading)
		{
			var isShowLoadingHandle = null, isShowLoadingTimeoutHandle = null, isTimeout = false;

			if (true == $.local)
			{
				var localResult = {};
				localResult[ERR_CODE] = ENONE;
				return callback && callback(localResult);
			}

			if (typeof url !== "string")
			{
				return false;
			}

			if ($.isFunction(data))
			{
				async = async || callback;
				callback = data;
				data = {};
			}

			async = async || typeof async === "undefined";
			utf8Encode = utf8Encode || typeof utf8Encode === "undefined";

			var array = new Array();
			var ret = true;
			var options = {
				'url':     url,
				'data':    data,
				'type':    'POST',
				'async':   async,
				'postDataType' : postDataType,
				'utf8Encode' : utf8Encode,
				'success': function(result)
				{
					function resultCallback(){
						if (callback)
						{
							try
							{
								ret = callback(result);
							}
							catch(e)
							{
								ret = null;
								if (async)
								{
									ret = false;
								}
							}
						}
					}

					if (isTimeout)
					{
						return false;
					}

					if (noShowLoading == undefined || noShowLoading == false)
					{
						if (isShowLoadingHandle != null || isShowLoadingTimeoutHandle != null)
						{
							if (isShowLoadingHandle != null)
							{
								clearTimeout(isShowLoadingHandle);
								isShowLoadingHandle = null;

								resultCallback();
							}
							else
							{
								requestShowLoadingCount--;
								if (requestShowLoadingCount == 0)
								{
									closeLoading(resultCallback);
								}
								else
								{
									resultCallback();
								}
							}

							clearTimeout(isShowLoadingTimeoutHandle);
							isShowLoadingTimeoutHandle = null;
						}
						else
						{
							return;
						}
					}
					else
					{
						resultCallback();
					}
				},
				"dataType" : "json"
			};

			if (postDataType == "json") {
				options.contentType = "application/json; charset=UTF-8";
			}

			if (!(noShowLoading != undefined && noShowLoading == true))
			{
				isShowLoadingHandle = $.setTimeout(function(){
					isShowLoadingHandle = null;
					isGlobalShowLoadingWorking = true;

					requestShowLoadingCount++;
					if (requestShowLoadingCount == 1)
					{
						showLoading();
					}

				}, REQ_TIMEOUT_SECONDS);

				isShowLoadingTimeoutHandle = $.setTimeout(function(){
					isShowLoadingHandle = null;
					isShowLoadingTimeoutHandle = null;

					isTimeout = true;

					requestShowLoadingCount--;
					if (requestShowLoadingCount == 0)
					{
						closeLoading(function(){
							isGlobalShowLoadingWorking = false;
							alarmDialog.show({content: errStr.cloudReqTimeout});	/* 提示语需要修改 */
							loadingDialog.hide();
						});
					}
				}, 15 * 1000);
			}

			$.ajax(options);

			return ret;
		},

		/* 发送DS数据 */
		sendDsReq: function(data, callback, async, method, noShowLoading)
		{
			var url = $.orgDsUrl();

			data.method = method;

			return $.sendAjaxReq(url, data, function(result){
				if (EUNAUTH == result[ERR_CODE])
				{
					return $.postDsUnAuthHandle(data, callback, async, result);
				}
				else
				{
					return callback && callback(result);
				}
			}, async, "json", undefined, noShowLoading);
		},

		/* 静态页面调试时返回的静态数据 */
		getLocalData: function(data, callback, async, method)
		{
			var ret = {};
			ret[ERR_CODE] = ENONE;

			if (method != "get")
			{
				for (var uciObj in data)
				{
					if ("method" != uciObj)
					{
						ret[uciObj] = localData[uciObj];
					}
				}
			}
			else
			{
				for (var uciObj in data)
				{
					if ("method" != uciObj)
					{
						var secObj = data[uciObj]["name"] ?
								(typeof(data[uciObj]["name"]) == "string" ? [data[uciObj]["name"]] : data[uciObj]["name"]) : [];
						secObj = secObj.concat(data[uciObj]["table"] ?
								(typeof(data[uciObj]["table"]) == "string" ? [data[uciObj]["table"]] : data[uciObj]["table"]) : []);
						ret[uciObj] = {};

						if (isArray(secObj))
						{
							for (var i = 0; i < secObj.length; i++)
							{
								ret[uciObj][secObj[i]] = localData[uciObj][secObj[i]];
							}
						}
						else
						{
							ret[uciObj][secObj] = localData[uciObj][secObj];
						}
					}
				}
			}

			return callback && callback(ret);
		},

		query: function(data, callback, async, noShowLoading)
		{
			if ($.local)
			{
				return $.getLocalData(data, callback, async, "get", noShowLoading);
			}
			else
			{
				return $.sendDsReq(data, callback, async, "get", noShowLoading);
			}
		},

		modify: function(data, callback, async, noShowLoading)
		{
			return $.sendDsReq(data, callback, async, "set", noShowLoading);
		},

		add: function(data, callback, async, noShowLoading)
		{
			return $.sendDsReq(data, callback, async, "add", noShowLoading);
		},

		del: function(data, callback, async, noShowLoading)
		{
			return $.sendDsReq(data, callback, async, "delete", noShowLoading);
		},

		action: function(data, callback, async, noShowLoading)
		{
			if ($.local)
			{
				return $.getLocalData(data, callback, async, "do", noShowLoading);
			}
			else
			{
				return $.sendDsReq(data, callback, async, "do", noShowLoading);
			}
		}
	});

	/* for auth */
	jQuery.extend({
		usr: "",
		pwd: "",
		authRltObj:
		{
			code: "",
			key: "",
			group: 0,
			dictionary: "",
			time: 0,
			client:"",
			bHandLg:false,
			authStatus:true,		/* true为通过认证, false为未通过认证 */
			authLog:null
		},
		loginErrHandle:{},
		externPageHandle:{},
		pagePRHandle:{},

		setLoginErrHandle: function(func)
		{
			$.loginErrHandle = function(handle){
				if (usernameSupport)
				{
					$.setLgUsr("");
				}
				$.setLgPwd("");
				func(handle);
			};
		},

		setExternPageHandle: function(func){
			$.externPageHandle = func;
		},

		setPRHandle: function(func){
			$.pagePRHandle = func;
		},

		orgDsUrl: function()
		{
			return "/stok=" + encodeURIComponent($.session) + "/ds";
		},

		securityEncode: function(input1, input2, input3)
		{
			var dictionary = input3;
			var output = "";
			var len, len1, len2, lenDict;
			var cl = 0xBB, cr = 0xBB;

			len1 = input1.length;
			len2 = input2.length;
			lenDict = dictionary.length;
			len = len1 > len2 ? len1 : len2;

			for (var index = 0; index < len; index++)
			{
				cl = 0xBB;
				cr = 0xBB;

				if (index >= len1)
				{
					cr = input2.charCodeAt(index);
				}
				else if (index >= len2)
				{
					cl = input1.charCodeAt(index);
				}
				else
				{
					cl = input1.charCodeAt(index);
					cr = input2.charCodeAt(index);
				}

				output += dictionary.charAt((cl ^ cr)%lenDict);
			}

			return output;
		},

		orgAuthPwd: function(pwd)
		{
			var strDe = "RDpbLfCPsJZ7fiv";
			var dic = "yLwVl0zKqws7LgKPRQ84Mdt708T1qQ3Ha7xv3H7NyU84p21BriUWBU43odz3iP4rBL3cD02KZciX"+
					  "TysVXiV8ngg6vL48rPJyAUw0HurW20xqxv9aYb4M9wK1Ae0wlro510qXeU07kV57fQMc8L6aLgML"+
					  "wygtc0F10a0Dg70TOoouyFhdysuRMO51yY5ZlOZZLEal1h0t9YQW0Ko7oBwmCAHoic4HYbUyVeU3"+
					  "sfQ1xtXcPcf1aT303wAQhv66qzW";

			return $.securityEncode(strDe, pwd, dic);
		},

		objCopy: function(target, srcObj)
		{
			var temp;
			for(var porperty in target)
			{
				temp = srcObj[porperty];
				if (temp != undefined)
				{
					target[porperty] = temp;
				}
			}
		},

		/* 设置用户名本地存储 */
		setLgUsr: function(usr)
		{
			try
			{
				sessionLS.setItem(LGUSRSTR, usr);
				$.usr = usr;
			}catch(ex){};
		},

		/* 设置密码本地存储 */
		setLgPwd: function(pwd)
		{
			try
			{
				sessionLS.setItem(LGKEYSTR, pwd);
				$.pwd = pwd;
			}catch(ex){};
		},

		/* 解析未认证成功的返回值 */
		parseAuthRlt: function(authRlt)
		{
			if (typeof authRlt == "object")
			{
				$.objCopy($.authRltObj, authRlt);
				$.authRltObj["group"] = parseInt($.authRltObj["group"], 10);
				$.pagePRHandle();
			}
		},

		logout: function()
		{
			var data = {system:{logout: "null"}};

			$.action(data, function(result){
				if (ENONE == result[ERR_CODE])
				{
					$.session = "";

					if (usernameSupport)
					{
						$.setLgUsr("");
					}
					$.setLgPwd("");
					setLoadPage("Content.htm", "Con");
					$.authRltObj["code"] = ESYSCLIENTNORMAL;
					showLogin();
					emptyNodes(id("Con"));
				}
			});
		},

		/* 获取登录错误日志 */
		queryAuthLog: function(callBack){
			var data = {query_auth_log:"null", method:"do"};

			return $.sendAjaxReq("/", data, function(result){
				if (true == $.local)
				{
					result[ERR_CODE] = ENONE;
				}

				return callBack && callBack(result);
			}, true, "json");
		},

		/* 续约 */
		postDsUnAuthHandle: function(data, callback, async, result)
		{
			if (EUNAUTH == result[ERR_CODE])
			{
				$.parseAuthRlt(result.data);

				if ((usernameSupport && (null == $.usr || 0 == $.usr.length)) ||
					null == $.pwd || 0 == $.pwd.length || ESYSRESET == $.authRltObj.code)
				{
					window.setTimeout(function()
					{
						$.loginErrHandle();
					}, 0);

					return;
				}

				function authHandle(err_code){
					if (ENONE == err_code)
					{
						/* 续约成功后再次发送中断的请求 */
						return $.sendAjaxReq($.orgDsUrl(), data, function(result){
							if (EUNAUTH == result[ERR_CODE])
							{
								$.parseAuthRlt(result.data);
								$.loginErrHandle();
							}
							else
							{
								return callback && callback(result);
							}
						}, async, "json");
					}
					else
					{
						/* 再次认证出错后，弹出认证框 */
						window.setTimeout(function()
						{
							$.loginErrHandle();
						}, 0);
					}
				}

				if (usernameSupport)
				{
					return $.authUsrPwd($.usr, $.pwd, authHandle, async);
				}
				else
				{
					return $.auth($.pwd, authHandle, async);
				}
			}
		},

		/* 修改默认的登录密码 */
		changeDefaultPwd: function(pwd, callBack)
		{
			var pwdStr = orgAuthPwd(pwd);
			var reqData = {
				method : "do",
				set_password : {
					password : pwdStr
				}
			};

			$.sendAjaxReq("", reqData,
				function(result){
					var err_code = result[ERR_CODE];

					if (ENONE == err_code)
					{
						$.setLgPwd(pwdStr);
						$.session = decodeURIComponent(result.stok);
						/*$.auth(pwdStr, function(err_code){
							callBack && callBack(err_code);
						});*/
					}

					callBack && callBack(err_code);
				},
				true,
				"json",
				undefined,
				true
			);
		},

		changePwd: function(oldPwd, newPwd, callBack)
		{
			var reqData = {
				system : {
					chg_pwd: {
						old_pwd : orgAuthPwd(oldPwd),
						new_pwd : orgAuthPwd(newPwd)
					}
				}
			};

			$.action(reqData, function(result){
				var err_code = result[ERR_CODE];

				if (ENONE == err_code)
				{
					$.setLgPwd(orgAuthPwd(newPwd));
				}

				(typeof callBack == "function") && callBack(err_code);
			});
		},

		/* 登录使用/修改密码 */
		auth: function(pwd, username, callBack, asyn)
		{
			if (typeof(username) == "function")
			{
				callBack = username;
				asyn = callBack;
				username = "";
			}
			var reqData, pwdStr;

			/* 密码格式错误 */
			if (pwd == undefined || 0 == pwd.length)
			{
				callBack && callBack(EUNAUTH);
			}

			asyn = asyn || typeof asyn === "undefined";

			/* 生成临时密钥 */
			//pwdStr = $.securityEncode($.authRltObj["key"], pwd, $.authRltObj["dictionary"]);
			reqData = {
				method: "do",
				login: {password: pwd}
			};

			/* 认证 */
			return $.sendAjaxReq("", reqData,
				function(result){
					var errCode = result[ERR_CODE];

					if (ENONE == errCode)
					{
						$.session = result.stok;
						$.setLgPwd(pwd);
					}
					else
					{
						$.parseAuthRlt(result.data);
					}

					return callBack && callBack(errCode);
				},
				asyn,
				"json"
			);
		},
		
		/* 修改默认的登录用户名和密码 */
		changeDefaultUsrPwd: function(usr, pwd, callBack)
		{
			var pwdStr = orgAuthPwd(pwd);
			var usrStr = usr;
			var reqData = {
				method : "do",
				set_password : {
					username : usrStr,
					password : pwdStr
				}
			};
			// $.accountStatus["logoutHandle"] = false;
			$.sendAjaxReq("", reqData,
				function(result){
					var err_code = result[ERR_CODE];
					if (ENONE == err_code)
					{
						$.authRltObj["authStatus"] = true;
						$.setLgUsr(usrStr);
						$.setLgPwd(pwdStr);
						$.session = decodeURIComponent(result.stok);
						/*$.auth(pwdStr, function(err_code){
							callBack && callBack(err_code);
						});*/
					}

					callBack && callBack(err_code);
				},
				true,
				"json"
			);
		},

		/* 修改用户名和密码 */
		changeUsrPwd: function(oldUsr, newUsr, oldPwd, newPwd, callBack)
		{
			var reqData = {
				system : {
					chg_pwd: {
						old_usr : oldUsr,
						new_usr : newUsr,
						old_pwd : orgAuthPwd(oldPwd),
						new_pwd : orgAuthPwd(newPwd)
					}
				}
			};

			$.action(reqData, function(result){
				var err_code = result[ERR_CODE];

				if (ENONE == err_code)
				{
					$.setLgUsr(newUsr);
					$.setLgPwd(orgAuthPwd(newPwd));
				}

				(typeof callBack == "function") && callBack(err_code);
			});
		},

		/* 移动维护账号修改普通账号用户名和密码 */
		changeOthersUsrPwd: function(oldUsr, newUsr, oldPwd, newPwd, callBack)
		{
			var reqData = {
				system : {
					chg_pwd: {
						old_usr : oldUsr,
						new_usr : newUsr,
						old_pwd : orgAuthPwd(oldPwd),
						new_pwd : orgAuthPwd(newPwd)
					}
				}
			};

			$.action(reqData, function(result){
				var err_code = result[ERR_CODE];

				if (ENONE == err_code)
				{
					// $.setLgUsr(newUsr);
					// $.setLgPwd(orgAuthPwd(newPwd));
				}

				(typeof callBack == "function") && callBack(err_code);
			});
		},

		/* 验证用户名和密码 */
		checkUsrPwd: function(usr, pwd, callBack, asyn)
		{
			var reqData, pwdStr;

			// $.accountStatus["logoutHandle"] = false;

			/* 用户名或密码格式错误 */
			if (usr == undefined || 0 == usr.length || pwd == undefined || 0 == pwd.length)
			{
				callBack && callBack(EUNAUTH);
			}

			asyn = asyn || typeof asyn === "undefined";

			/* 生成临时密钥 */
			/* pwdStr = $.securityEncode($.authRltObj["key"], pwd, $.authRltObj["dictionary"]); */

			reqData = {
				method: "do",
				login: {username: usr, password: pwd}
			};

			/* 认证 */
			return $.sendAjaxReq("", reqData,
				function(result){
					var errCode = result[ERR_CODE];

					// if (ENONE == errCode)
					// {
					// 	$.session = decodeURIComponent(result.stok);
					// 	$.setLgUsr(usr);
					// 	$.setLgPwd(pwd);
					// 	$.authRltObj["authStatus"] = true;

					// 	/* 15分钟页面不操作则自动超时 */
					// 	startLogoutTimer();
					// 	$("body").bind("click", startLogoutTimer);
					// }
					// else
					// {
					// 	// $.authRltObj["authStatus"] = false;
					// 	// $.parseAuthRlt(result.data);
					// }

					return callBack && callBack(errCode);
				},
				asyn,
				"json"
			);
		},

		/* 登录使用用户名和密码 */
		authUsrPwd: function(usr, pwd, callBack, asyn)
		{
			var reqData, pwdStr;

			// $.accountStatus["logoutHandle"] = false;

			/* 用户名或密码格式错误 */
			if (usr == undefined || 0 == usr.length || pwd == undefined || 0 == pwd.length)
			{
				callBack && callBack(EUNAUTH);
			}

			asyn = asyn || typeof asyn === "undefined";

			/* 生成临时密钥 */
			/* pwdStr = $.securityEncode($.authRltObj["key"], pwd, $.authRltObj["dictionary"]); */

			reqData = {
				method: "do",
				login: {username: usr, password: pwd}
			};

			/* 认证 */
			return $.sendAjaxReq("", reqData,
				function(result){
					var errCode = result[ERR_CODE];

					if (ENONE == errCode)
					{
						$.session = decodeURIComponent(result.stok);
						$.setLgUsr(usr);
						$.setLgPwd(pwd);
						$.authRltObj["authStatus"] = true;

						/* 15分钟页面不操作则自动超时 */
						// startLogoutTimer();
						// $("body").bind("click", startLogoutTimer);
					}
					else
					{
						$.authRltObj["authStatus"] = false;
						$.parseAuthRlt(result.data);
					}

					return callBack && callBack(errCode);
				},
				asyn,
				"json"
			);
		}
	});
})();