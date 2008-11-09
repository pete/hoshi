#!/usr/bin/env ruby

# Perl, eat your heart out.

require 'rubygems'
require 'hoshi'

qstring = ENV.delete 'QUERY_STRING'
query = CGI.parse qstring if qstring

Hoshi::View(:html4) {
	doc {
		head { title "env.cgi, just like Mom used to make" }
		body {
			h1 "CGI Environment:"
			ul { 
				ENV.to_a.sort.map { |k,v|
					li CGI.escapeHTML("#{k} => #{v}")
				}
			}

			if query
				h1 "Arguments:"
				ul {
					query.sort.map { |k,v| 
						li {
							safe "#{k} = "
							if v.size == 1
								safe v
							else
								ul { v.map { |sv| li { safe sv } } }
							end
						}
					}
				}
			else
				h1 "No Arguments"
			end
		}
	}
	render_cgi
}
