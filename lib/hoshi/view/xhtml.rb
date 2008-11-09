require 'hoshi/view/html'

class Hoshi::View
	class XHTML < HTML
		def self.content_type
			'application/xhtml+xml'
		end
	end
end
