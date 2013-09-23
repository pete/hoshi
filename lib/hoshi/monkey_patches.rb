class Hash
	# Makes this hash fit to be put into a tag.
	# { :a => 1, :b => "two", :c => true }.to_html_options # => 'a="one" b="two" c'
	def to_html_options double_quotes = true
		qchar = double_quotes ? '"' : "'"
		map { |k,v|
			if v == true
				k.to_s
			else
				"#{k}=#{qchar}#{v}#{qchar}"
			end
		}.join(' ')
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
