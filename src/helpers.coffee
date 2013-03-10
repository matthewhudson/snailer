exports.getHostname = (url) ->
		parts = url
						.replace('http://','')
						.replace('https://','')
						.split(/[/?\u0023]/)

		parts[0]