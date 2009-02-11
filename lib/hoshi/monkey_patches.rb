class Hash
	# Makes this hash fit to be put into a tag.
	# { :a => 1, :b => "two" }.to_html_options # => 'a="one" b="two"'
	def to_html_options double_quotes = true
		qchar = double_quotes ? '"' : "'"
		map { |k,v| "#{k}=#{qchar}#{v}#{qchar}" }.join(' ')
	end
end

# We've dropped facets, and are now shooting for compatibility across Ruby
# versions, so we add Symbol#to_proc unless it exists.
unless((Symbol.instance_method(:to_proc) rescue nil))
	class Symbol
		def to_proc
			proc { |obj, *args| obj.send(self, *args) }
		end
	end
end
