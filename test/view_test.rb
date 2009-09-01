require 'hoshi'

class TestView < Hoshi::View :html
	tags *%w(regular)
	open_tags *%w(open)
	self_closing_tags *%(closer) # The only for whom coffee is.
end

class ViewTest < Test::Unit::TestCase
	def test_class_tags
		t = TestView.new

		t.regular
		assert_equal "<regular></regular>", t.render
		t.clear!

		t.regular "a"
		assert_equal "<regular>a</regular>", t.render
		t.clear!

		t.open
		assert_equal "<open>\n", t.render
		t.clear!

		t.open "a"
		assert_equal "<open>a\n", t.render
		t.clear!

		t.closer
		assert_equal "<closer />", t.render
		t.clear!

		t.closer "coffee"
		assert_equal "<closer>coffee</closer>", t.render
		t.clear!
	end
end
