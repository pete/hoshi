# TODO:  When 1.9 goes away, monkey-patching should be changed to refinements.
# See: http://blog.headius.com/2012/11/refining-ruby.html

class Hash
	# Makes this hash fit to be put into a tag.
	# {a: 1, b: "two", c: true}.to_html_options # => 'a="one" b="two" c'
	def to_html_options double_quotes = true
		qchar = double_quotes ? '"' : "'"
		map { |k,v|
			if v == true # Intentional.
				k.to_s
			else
				"#{k}=#{qchar}#{v.to_s.gsub(qchar, CGI.escapeHTML(qchar))}#{qchar}"
			end
		}.join(' ')
	end
end
