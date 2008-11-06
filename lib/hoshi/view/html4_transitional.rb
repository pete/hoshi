require 'hoshi/view/html'

class Hoshi::View
	class HTML4Transitional < HTML
		self.doctype = "<DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 " \
			"Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">"
	end
end
