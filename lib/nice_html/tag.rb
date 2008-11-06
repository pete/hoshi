class NiceHTML
	# Represents an HTML tag.
	class Tag
		attr_accessor :name, :close_type

		def initialize(name, close_type = nil)
			@name, @close_type = name, close_type
		end

		def render(inside = nil, opts = {})
			inside = inside.to_s

			s = "<#{name} #{opts.to_html_options}".strip
			if inside.empty? && close_type == :self
				return s << "/>"
			end

			s << ">" << inside

			if close_type == :none
				s
			else
				s << "</#{name}>"
			end
		end
	end
end
