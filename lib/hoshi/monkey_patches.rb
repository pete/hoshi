# TODO: When 1.9 goes away, this monkey-patch should be changed to refinements, or
# just moved into a private instance method for Hoshi::Tag.
# See: http://blog.headius.com/2012/11/refining-ruby.html

class Hash
	# Makes this hash fit to be put into a tag.
	# 	{a: 1, b: "two", c: true, d: false}.to_html_options # => 'a="one" b="two" c'
	# Note that true and false are special-cased, true to allow for attributes that
	# do not have a value and false for convenience, to allow for, e.g., inline
	# conditionals.
	def to_html_options double_quotes = true
		qchar = double_quotes ? '"' : "'"
		map { |k,v|
			if v == true # Intentional.
				k.to_s
			elsif v == false
				''
			else
				"#{k}=#{qchar}#{v.to_s.gsub(qchar, CGI.escapeHTML(qchar))}#{qchar}"
			end
		}.join(' ')
	end
end
