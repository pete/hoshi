require 'hoshi/view/xhtml'

class Hoshi::View
	class XHTML1 < XHTML
		dtd! "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" " \
			"\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">"
	end
end
