# [SNAIL](https://github.com/matthewhudson/snail)

#### Frontend test and audit framework. Extensible with plugins.

Snail is a web-crawler with support for plugins (via [WebPipes](http://www.webpipes.org/)) to test certain conditions.

## Introduction

Snail is *not* a node.js module, it's a daemon and CLI for comprehensively testing and auditing the performance of web applications.

### Installation

Global installation is highly recommended in order to gain access to the CLI and plugins.

	$ npm -g install snail

## Example Plugins

* Average, mean, median, max page size
* Response time
* Number of asset hosts
* Assets on CDN?
* Assets Cacheable?
* Mobile Cacheable?
* Selector Caching
* Cache Function Pointers ([e.g.](http://blogs.msdn.com/b/ie/archive/2006/08/28/728654.aspx))
* Do certain page vars/selectors exist?
* Are certain assets present?
* Status codes
* Certain DOM elements present? disqus?
* Retina assets?
* Scan for spelling mistakes/grammar
* Scan for injections, or vulnerabites. 
* Forms without CSRF
* YSlow stats
* Find dead CSS
* Find dead JS (based on selector)
* Determine if certain "dead" marketing-speak isn't supposed to appear.
