require 'nice_html/view/html'

class NiceHTML::View
	class HTML4 < HTML
		permissive!

		tags *%w(
				)
	end
end

