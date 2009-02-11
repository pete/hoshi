module Hoshi
	class View
		# This method is a fallback for pre-1.8.7 Ruby; if a syntax error is
		# encountered when hoshi/view.rb tries to load hoshi/view-tag.rb, this
		# file is loaded.  I have really been trying to avoid eval()ing strings
		# (for religious reasons), but have to make this concession.
		def self.tag(name, close_type = nil)
			class_eval <<-EOHACK
				def #{name}(*opts, &b)
					if b
						tag #{name.inspect}, #{close_type.inspect}, *opts, &b
					else
						tag #{name.inspect}, #{close_type.inspect}, *opts, &b
					end
				end
			EOHACK
		end
	end
end
