#!/usr/bin/env ruby

require 'rubygems'
require 'hoshi'

class Feed < Hoshi::View :html
	permissive!
	def show
		raw "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
		raw "<?xml-stylesheet href=\"http://feeds.feedburner.com/~d/styles/rss2full.xsl\" type=\"text/xsl\" media=\"screen\"?>"
		raw "<?xml-stylesheet href=\"http://feeds.feedburner.com/~d/styles/itemcontent.css\" type=\"text/css\" media=\"screen\"?>"
		rss("xmlns:wfw"=>"http://wellformedweb.org/CommentAPI/", "xmlns:atom"=>"http://www.w3.org/2005/Atom", "version"=>"2.0", "xmlns:content"=>"http://purl.org/rss/1.0/modules/content/", "xmlns:dc"=>"http://purl.org/dc/elements/1.1/") {
			channel {
				title "Debugs"
				link "http://debu.gs/blog/debugs.rss"
				description
				language "en"
				tag "atom10:link", nil, "href"=>"http://feeds.feedburner.com/debugs", "rel"=>"self", "xmlns:atom10"=>"http://www.w3.org/2005/Atom", "type"=>"application/rss+xml"
				item {
					title "Hoshi 0.1.0 Released...Soon"
					link "http://debu.gs/hoshi-010-released"
					pubDate "Thu, 06 Nov 2008 00:00:00 +0000"
					description "Bringing first-class views to Ruby."
				}
				item {
					title "LiveConsole 0.2.0 Released"
					link "http://debu.gs/liveconsole-020-released"
					pubDate "Thu, 16 Oct 2008 00:00:00 +0000"
					description "LiveConsole 0.2.0 released with support for Unix Domain Sockets and arbitrary bindings."
				}
			}
		}
		render
	end
end

if __FILE__ == $0
	require 'cgi'
	puts CGI.pretty(Feed.new.show)
end
