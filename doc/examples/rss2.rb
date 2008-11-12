require 'hoshi'
require 'ostruct'

class BlogFeed < Hoshi::View :rss2
	def initialize(blog)
		super()

		# This will generate the inside of the channel tag.
		def_channel { 
			title blog.title
			link blog.url
			description blog.description
		}

		# This block gets called once per item.
		def_item { |i|
			title i.title
			link i.url
			description i.summary
			# pub_date is a helper for pubDate:
			pub_date i.time
			author i.author.email if i.author
		}

		# You need items to have a feed.
		self.items = blog.entries
	end
end

# We're going to stub out a fake blog object full of fake entries before we get
# to the good part.
blog = OpenStruct.new(:title => 'Hello, world of syndication!',
					  :url => 'http://www.example.com/blog',
					  :description => 'Nope, no, not at all.')

author = Struct.new(:email)
blog.entries = [
	{ :title => "first ps0t!!!1!", 
	  :url => 'http://www.example.com/blog/first_psot',
	  :description => 'This is the first post.',
	  :time => (Time.now - 60 * 60 * 24),
	  :author => author.new('biff@example.com'),
	},
	{ :title => "What is with Biff?",
	  :url => 'http://www.example.com/blog/biff_sux',
	  :description => 'Jerk stole the first post from me.',
	  :time => Time.now,
	  :author => author.new('emily_postnews@example.com'),
	},
].map &OpenStruct.method(:new)

puts BlogFeed.new(blog).render
