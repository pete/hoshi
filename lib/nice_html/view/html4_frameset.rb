require 'nice_html/view/html'

class NiceHTML::View
	class HTML4Frameset < HTML4
		self.doctype = "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 " \
			"Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\">"
	end
end
