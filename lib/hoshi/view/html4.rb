require 'hoshi/view/html'

class Hoshi::View
	class HTML4 < HTML
		dtd! "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" " \
			"\"http://www.w3.org/TR/html4/strict.dtd\">"


		tags *%w(a address applet area base basefont bdo blockquote body br
				 button caption center col colgroup dd div dl dt fieldset font
				 form frame frameset h1 h2 h3 h4 h5 h6 head hr html iframe img
				 input isindex label legend li link map meta noframes noscript
				 object ol optgroup option p param pre q script select span
				 style table tbody textarea tfoot thead title tr td ul)
	end
end

