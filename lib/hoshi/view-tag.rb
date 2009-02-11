module Hoshi
	class View
		# This creates an instance method for this view which appends a tag.
		# Most of these are handled for you.  The arguments to this method
		# match those to Tag.new.  See also View#permissive!.
		# 	tag('h1')
		# 	def show_an_h1
		# 		h1 "I have been shown"
		# 	end
		def self.tag(name, close_type = nil)
			define_method(name) { |*opts,&b|
				if b
					tag name, close_type, *opts, &b
				else
					tag name, close_type, *opts
				end
			}
		end
	end
end
