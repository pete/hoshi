require 'hpricot'

module Hoshi
	# A semi-hacky method for converting HTML text to a Hoshi method.  It takes
	# an HTML document as a string, and optionally the string to use for each
	# level of indentation.
	def self.from_html(html, indent = "\t")
		"#{indent}def page" << tree_to_hoshi(parse(html), indent, 2) <<
			"\n#{indent * 2}render\n#{indent}end"
	end

	private

	def self.parse(doc)
		Hpricot.method(
			if doc.include?('<?xml') # Seems like a safe assumption.
				:XML
			else
				:parse
			end).call(doc)
	end

	def self.tree_to_hoshi(tree, indent = "\t", indentlevel = 0)
		idt = indent * indentlevel
		str = ''
		tree.each_child { |i|
			str << ("\n#{idt}" <<
			case i
			when Hpricot::Elem
				# Something simple that resembles rules for ruby method naming.
				# I know that both XML and Ruby allow most valid unicode 
				# characters in tags/method names, but this is Good Enough.
				using_tag = !/^[a-z][a-zA-Z0-9_]*[!?]?$/.match(i.name)

				args, block = [], nil
				s = if using_tag
						args << i.name.inspect << 'nil'
						'tag'
					else
						i.name
					end

				if i.children.size == 1 && 
				   i.children.first.kind_of?(Hpricot::Text)
					fc = i.children.first.to_s.strip
					args << fc.inspect unless fc.empty?
				elsif !i.children.empty?
					block = ' {' << 
						tree_to_hoshi(i, indent, indentlevel + 1) <<
						"\n#{idt}}"
				end

				unless i.attributes.empty?
					args << i.attributes.inspect.sub(/^\{/, '').sub(/\}$/, '')
				end

				unless args.empty?
					arg_s = args.join(', ')
					if block
						s << "(#{arg_s})"
					else
						s << " #{arg_s}"
					end
				end

				s << block if block

				s
			when Hpricot::Comment
				"comment #{i.content.inspect}"
			when Hpricot::BogusETag
				"raw #{i.to_s.inspect} # Dangling end tag."
			when Hpricot::DocType, Hpricot::ProcIns, Hpricot::XMLDecl, 
			     Hpricot::Text, Object
				x = i.to_s
				if /\A\s*\Z/.match(x)
					next
				else
					"raw #{i.to_s.strip.inspect}"
				end
			end)
		}
		str
	end
end
