require 'rubyful_soup'

module Hoshi
	# A semi-hacky method for converting HTML text to a Hoshi method.  It takes
	# an HTML document as a string, and optionally the string to use for each
	# level of indentation.
	def self.from_html(html, indent = "\t")
		"#{indent}def page" << tree_to_hoshi(parse(html), indent, 2) <<
			"\n#{indent * 2}render\n#{indent}end"
	end

	private

	def self.parse(html)
		BeautifulSoup.new(html)
	end

	def self.tree_to_hoshi(tree, indent = "\t", indentlevel = 0)
		idt = indent * indentlevel
		(tree.to_a rescue []).inject('') { |str, i|
			next(str) if i == "\n"
			str << "\n#{idt}" << 
			if i.kind_of? ::Tag # RubyfulSoup:  namespaceless.  orz
				s = i.name.dup

				unless i.attrs.empty?
					attrs = i.attrs.dup
					# Workaround for an apparent RubyfulSoup bug:
					attrs.delete('img') if i.name == 'img'
					s << '(' << 
						attrs.inspect.sub(/^\{/, '').sub(/\}$/, '') << ')'
				end

				inner = tree_to_hoshi i, indent, indentlevel + 1
				if inner.empty?
					s
				else
					s << " {#{inner}\n#{idt}}"
				end
			else
				"raw #{i.to_s.inspect}"
			end
		}
	end
end
