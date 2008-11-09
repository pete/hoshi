require 'metaid'
require 'cgi'

module Hoshi
	# The View class is the super-class for views you create with Hoshi.  More
	# likely, though, you'll be using one of View's many sub-classes as the
	# super-class for your view, like this:
	#   class MyView < Hoshi::View :html4
	# or
	#   class MyView < Hoshi::View::XHTML1Frameset
	# Of course, using View[] is the preferred method for the sake of brevity.
	# When you create a view class, you'll want to define one or more methods
	# that eventually call View#render, which turns your view into HTML.
	# (Private methods and methods that build up state do not need to do so.)
	class View
		class ValidationError < StandardError; end

		# This creates an instance method for this view which appends a tag.
		# Most of these are handled for you.  The arguments to this method
		# match those to Tag.new.  See also View#permissive!.
		# 	tag('h1')
		# 	def show_an_h1
		# 		h1 "I have been shown"
		# 		render
		# 	end
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

		# A short-hand for creating multiple tags via View.tag.  For tags that
		# do not require closing, see View.open_tags.
		def self.tags *names
			names.map &method(:tag)
		end

		# A short-hand for creating multiple tags that are left open.
		def self.open_tags *names
			names.map { |n| tag n, :none }
		end

		# This method choses, based on the provided doctype, the proper
		# sub-class of View.  Generally, you'll be using this rather than
		# sub-classing View directly.  The doctype argument is case- and
		# underscore-insensitive, and valid arguments are names of View
		# subclasses that are inside the View namespace.
		def self.[] doctype
			doctype = doctype.to_s.downcase.gsub('_', '')
			const_get(constants.find { |c| 
				cl = const_get c
				cl.ancestors.include?(self) && c.downcase == doctype
			}) rescue nil
		end

		# Sets the doctype declaration for this class.
		def self.dtd! dtd
			dtd += "\n"
			define_method(:doctype) { append! dtd }
		end
		def doctype
			comment "No doctype defined; are you sub-classing View directly " \
				"and not calling dtd!()?"
		end

		# Free-form tags.  Basically, dynamic tag creation by method_missing.
		def self.permissive!
			@permissive = true
		end

		# Returns true if we add tags to this class on the fly.
		def self.permissive?
			@permissive
		end

		# Only the tags already specified are allowed.  No dynamic tag
		# creation.
		def self.strict!
			@permissive = false
		end

		# Returns true if we do not add tags to the class on the fly.
		def self.strict?
			!permissive?
		end

		# Create and render a view via a block.
		def self.build(&block)
			c = new
			c.instance_eval(&block)
			c.render
		end

		# This is overridden in HTML/XHTML, and you'll definitely want to
		# override it if you subclass View directly.
		def self.content_type
			'application/octet-stream'
		end

		# Most of these files depend on the above method definitions.
		Dir["#{File.dirname(__FILE__)}/view/*.rb"].each &method(:require)

		def initialize
			clear!
		end

		# Clears the current state of this view.
		def clear!
			self.tree = []
			self.current = tree
		end

		# Adds a comment.
		def comment(*a)
			if a.include?('--')
				raise ValidationError, "Comments can't include '--'."
			else
				append! "<!-- #{a} -->"
			end
		end

		# Appends a tag to the current document, for when a tag is only needed
		# once or has a name that is not a valid method name.
		def tag(tname, close_type = nil, inside = nil, opts = {})
			append! Tag.new(tname, close_type).render(inside, opts)
		end

		# Appends something to the document.  The comment, decl, and various
		# tag methods call this.
		def append! x
			current << x
			x
		end

		# If you're tired of typing "doctype\nhtml" every single time.
		def doc &b
			doctype
			html &b
		end

		# Turns things in to strings, properly escapes them, and appends them
		# to the document.
		def safe *things
			append! CGI.escapeHTML(things.map(&:to_s).join("\n"))
		end

		# Appends one or more non-escaped strings to the document.
		def raw *things
			append! things.join
		end

		# Returns the string representation of the document.  This is what you
		# want to eventually call.
		def render
			tree.flatten.map(&:to_s).join
		end

		# Prints the string representation of the docutment, with HTTP headers.
		# Useful for one-off CGI scripts.  Takes an optional hash argument for
		# headers (Content-Type and Status are set by default).  See CGI#header
		# for information on how the header hash should look.
		def render_cgi(extra_headers = {})
			h = { 
				'type' => self.class.content_type,
				'status' => 'OK',
			}.merge(extra_headers)

			CGI.new.out(h) { render }
		end

		# Dynamically add tags if the view class for this object is permissive.
		def method_missing(mname, *args)
			if self.class.permissive?
				self.class.tag mname
				send mname, *args
			else
				super
			end
		end

		private

		attr_accessor :tree, :current
	end
end
