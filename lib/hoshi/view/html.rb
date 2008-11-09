class Hoshi::View
	class HTML < self
		tags *%w(html head body)

		def self.content_type
			'text/html'
		end

		def cdata str
			append! "<![CDATA[\n" + str + "\n]]>"
		end
	end
end
