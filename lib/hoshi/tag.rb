module Hoshi
	# Represents an HTML tag.  You usually won't be using this class directly.
	class Tag
		attr_accessor :name, :close_type

		# A tag currently has only two attributes:  a name and a method for
		# closing it, which both decide how it is rendered as a string. 
		# A self-closing tag:
		#   Tag.new('test', :self).render # => "<test />"
		# A tag that does not need to close:
		#   Tag.new('test', :none).render('test this') # => "<test>test this\n"
		# And a regular tag:
		#   Tag.new('test').render # => "<test></test>"
		def initialize(name, close_type = nil)
			@name, @close_type = name, close_type
		end

		# Generates a string from this tag.  inside should be the contents to
		# put between the opening and closing tags (if any), and opts are the
		# HTML options to put in the tag.  For example,
		#   Tag.new('div').render('Click for an alert.', 
		#                         :onclick => "alert('Hi.');")
		# gets you this:
		#   <div onclick="alert('Hi.');">Click for an alert.</div>
		def render(inside = nil, opts = {})
			inside = inside

			s = "<#{name} #{opts.to_html_options}"
			s.chomp! ' '
			if((!inside || inside.empty?) && close_type == :self)
				return s << " />"
			end

			s << ">"
			s << inside if inside

			if close_type == :none
				s << "\n"
			else
				s << "</#{name}>"
			end
		end
	end
end
