# Goals
The goal of this document is to describe a future Varnish setup for fast caching of pages, assets and content. Varnish is begin set up to only cache pages that are public. It should ignore private and TCL only works so as not to leak them to the public. The expectation of this configuration is that Varnish will be configured between the load balancer and Passenger. So the current configuration of web > lb > passenger becomes web > lb > varnish > passenger.

# Example Config
The `ops/varnish.vcl` example file shows how the docker setup would be configured.  The expectation is that the value in backend default host will be changes form `web:3000` to the address of the running passenger instance. There is a block to prevent any backend pages from being cached. Private and TLC Only works are blocked from caching due to their Cache-Control: no-cache headers.  Note that in development mode, Rails uses a private; max-age: 0 header on all pages, which also prevents caching. Changing the default varnish start up command in one of `/etc/default/varnish`, `/etc/sysconfig/varnish` or possibly `/etc/systemd/system/varnish.service` so that it includes two -s commands like so

```
-s default=malloc,4G \
-s static=file,/var/lib/varnish/varnish_storage.bin,100G"
```

be sure to customize the 4G of memory and 100G of disk space to numbers that work for your resources.

# Testing
In an environment with the Rails cache prevention off (either by modifying development.rb or by using staging or production environments), page headers easily tell the story of what Varnish is doing. On pages where Varnish is being hit, once sees the X-Varnish header and an Age header greater than 0. An age of 0 means this was the first hit on the page, the page has a no-cache header or otherwise was not in the cache yet. On Hyrax backend pages, there is no X-Varnish header as those pages are blocked from caching completely by the configuration being provided here. It is easiest to see headers in the Network tab of your browsers debugging tools or using `curl -I`

# Installation
Any version of Varnish after 4.0 can be used.  We tested version 6.0.7-1 as it was the latest stable version published to Docker Hub at time of writing. Varnish should ideally be installed from the system package manager (apt or yum install varnish). We see no reason to use the -plus version for this application.
