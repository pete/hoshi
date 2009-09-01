require 'hoshi'

class TagTest < Test::Unit::TestCase
	include Hoshi
	def test_closing_types
		t = Tag.new('tag')
		assert_equal '<tag></tag>', t.render
		assert_equal '<tag>a</tag>', t.render('a')

		t = Tag.new('tag', :self)
		assert_equal '<tag />', t.render
		assert_equal '<tag>a</tag>', t.render('a')

		t = Tag.new('tag', :none)
		assert_equal "<tag>\n", t.render
		assert_equal "<tag>a\n", t.render('a')
	end
end
