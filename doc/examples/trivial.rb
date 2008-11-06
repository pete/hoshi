require 'hoshi'

class Trivial < Hoshi::View :html4
	def show
		doctype
		html {
			head {
			title "Hello, world!"
			link :rel => 'stylesheet', :href => '/css/hoshi.css'
		}

		body {
			h1 "Hello, world!"
			p "This is a greeting to the world."
		}
		}
		render
	end
end

puts Trivial.new.show
