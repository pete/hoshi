require 'hoshi'

# Just a regression test, written to try to isolate an apparent bug.
# (It turns out that the bug had already been fixed, which is why I
# couldn't reproduce it.  Doesn't quite hurt to leave it in, though.)
class HTML5Test < Test::Unit::TestCase
	class SC < Hoshi::View(:html5)
		def thing &b
			html { body { yield } }
		end
	end

	def test_some_tags
		v = Hoshi::View(:html5).new
		s = Class.new(Hoshi::View(:html5)).new
		%i(
			hr
			br
			img
		).each { |tn|
			v = SC.new
			v.send tn
			assert_equal "<#{tn}>", v.render.chomp

			v = SC.new
			v.send(tn, attr: 'val')
			assert_equal "<#{tn} attr=\"val\">", v.render.chomp

			v = SC.new
			v.div { v.send(tn) }
			assert_equal "<div><#{tn}></div>", v.render.gsub(/\n/, '')

			v = SC.new
			v.div { v.send(tn); v.send(tn) }
			assert_equal "<div><#{tn}><#{tn}></div>", v.render.gsub(/\n/, '')

			v = SC.new
			v.thing { v.send(tn); v.send(tn) }
			assert_equal "<html><body><#{tn}><#{tn}></body></html>", v.render.gsub(/\n/, '')
		}
	end
end
