require 'facets/symbol'
require 'hoshi/monkey_patches'

require 'hoshi/tag'
require 'hoshi/view'

# This is the 
module Hoshi
	# This is a cosmetic method; you may do Hoshi::View[:type],
	# Hoshi::View(:type), or Hoshi::View :type
	def self.View(*a)
		View[*a]
	end
end
