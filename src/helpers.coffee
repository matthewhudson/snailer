exports.getHostname = (url) ->
    parts = url
            .replace('http://','')
            .replace('https://','')
            .replace('www.','')
            .split(/[/?\u0023]/)

    parts[0]