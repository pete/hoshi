require 'time' # Doesn't everything?

class Hoshi::View
	class RSS2 < self
		class InvalidItemError < ValidationError; end
		class InvalidChannelError < ValidationError; end

		tags *%w(author category channel cloud comments copyright description
				 docs enclosure generator guid item language lastBuildDate link
				 managingEditor pubDate rating skipDays skipHours source title
				 ttl webMaster rss image url )

		attr_accessor :channel_block, :item_block, :items

		dtd! "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"

		def self.content_type
			'application/rss+xml'
		end

		def def_channel &b
			self.channel_block = b
		end

		def each_item &b
			self.item_block = b
		end

		# A small helper so you can just pass a date, time, or string rather
		# than worrying about format.
		def pub_date dt
			dt =
				case dt
				when Time, Date, DateTime
					dt.rfc822
				else
					dt
				end
			pubDate dt
		end

		def render
			clear!
			doctype
			rss(:version => '2.0') {
				channel {
					channel_block.call
					items.each { |i| 
						item { item_block.call i }
					}
				}
			}
			super()
		end
	end
end
