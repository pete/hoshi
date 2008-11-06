class NiceHTML
	class View
		class ValidationError < StandardError; end

		def self.tag(name, close_type = nil)
			tag = Tag.new(name, close_type)
			define_method(name) { |*opts,&b|
				if b
					old, self.current = current, []
					b.call
					inside, self.current = current.map(&:to_s).join, old
				else
					inside = opts.shift if opts.first.kind_of?(String)
				end

				append! tag.render(inside, opts.first || {})
			}
		end

		def self.tags(*names)
			names.map &method(:tag)
		end

		def self.[] doctype
			const_get(constants.find { |c| 
				cl = const_get c
				cl.ancestors.include?(self) && 
					c.downcase == doctype.to_s.downcase
			}) rescue nil
		end

		def self.decl(*a)
		end

		# Free-form tags.  Basically, dynamic tag creation by method_missing.
		def self.permissive!
			@permissive = true
		end

		# Only the tags already specified are allowed.  No dynamic tag
		# creation.
		def self.strict!
			@permissive = false
		end

		# Most of these files depend on the above method definitions.
		Dir["#{File.dirname(__FILE__)}/view/*.rb"].each &method(:require)

		def initialize
			self.tree = []
			self.current = tree
		end

		def comment(*a)
			if a.include?('--')
				raise ValidationError, "Comments can't include '--'."
			else
				append! "<!-- #{a} -->"
			end
		end

		def append! x
			current << x
			x
		end

		def render
			tree.flatten.map(&:to_s).join
		end

		def method_missing(mname, *args)
			if @permissive
				tag mname
				send mname, *args
			else
				super
			end
		end

		private

		attr_accessor :tree, :current
	end
end
