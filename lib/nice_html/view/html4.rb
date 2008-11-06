require 'nice_html/view/html'

class NiceHTML::View
	class HTML4 < HTML
		self.doctype = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" " \
			"\"http://www.w3.org/TR/html4/strict.dtd\">"


		tags *%w(a address applet area base basefont bdo blockquote body br
				 button caption center col colgroup dd div dl dt fieldset font
				 form frame frameset head hr html iframe img input isindex
				 label legend li link map meta noframes noscript object ol
				 optgroup option p param pre q script select span style table
				 tbody textarea tfoot thead title tr ul)
	end
end

