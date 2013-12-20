require 'hoshi'

class TagTest < Test::Unit::TestCase
	include Hoshi
	def test_closing_types
		t = Tag.new('tag')
		assert_equal '<tag></tag>', t.render
		assert_equal '<tag>a</tag>', t.render('a')
		assert_equal '<tag k="v"></tag>', t.render(nil, 'k' => 'v')
		assert_equal '<tag k></tag>', t.render(nil, 'k' => true)

		t = Tag.new('tag', :self)
		assert_equal '<tag />', t.render
		assert_equal '<tag>a</tag>', t.render('a')

		t = Tag.new('tag', :none)
		assert_equal "<tag>\n", t.render
		assert_equal "<tag>a\n", t.render('a')
		assert_equal "<tag k=\"v\">\n", t.render(nil, 'k' => 'v')
		assert_equal "<tag k>\n", t.render(nil, 'k' => true)
	end

	def test_quoted_values
		t = Tag.new('tag', :none)
		assert_equal "<tag k=\"&quot;\">\n", t.render(nil, 'k' => '"')
	end
end
