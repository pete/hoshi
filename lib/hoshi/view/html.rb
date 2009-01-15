class Hoshi::View
	class HTML < self
		# So, 'p' may look a little out of place here, but if you sub-class
		# View(:html) directly and use permissive!, you'll end up with Kernel#p
		# rather than a <p> tag.  Almost never what you want.
		tags *%w(html head body p)

		def self.content_type
			'text/html'
		end

		def cdata str
			append! "<![CDATA[\n" + str + "\n]]>"
		end

		# Includes the stylesheets from the list passed as arguments.
		def css_includes *ss
			ss.each { |s|
				link :rel => 'stylesheet', :media => 'all', :href => s
			}
		end
	end
end
