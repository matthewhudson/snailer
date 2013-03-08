# [SNAIL](https://github.com/matthewhudson/snail)

##### Frontend test and audit framework. Extensible with plugins.

Snail crawls a domain until no more unique URLS are left. Snail supports JS plugins (and WebHooks) to test certain conditions.

## Example Plugins

* Average, mean, median, max page size
* Response time
* Number of asset hosts
* Assets on CDN?
* Assets Cacheable?
* Mobile Cacheable?
* Do certain page vars/selectors exist?
* Are certain assets present?
* Status codes
* Certain DOM elements present? disqus?
* Retina assets?
* Scan for spelling mistakes/grammar
* Scan for injections, or vulnerabites. 
* Forms without CSRF
* YSlow stats