class Hash
	# Makes this hash fit to be put into a tag.
	# { :a => 1, :b => "two" }.to_html_options # => 'a="one" b="two"'
	def to_html_options double_quotes = true
		qchar = double_quotes ? '"' : "'"
		map { |k,v| "#{k}=#{qchar}#{v}#{qchar}" }.join(' ')
	end
end
