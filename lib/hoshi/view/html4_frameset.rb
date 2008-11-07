require 'hoshi/view/html4'

class Hoshi::View
	class HTML4Frameset < HTML4
		dtd! "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 " \
			"Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\">"
	end
end
