require 'hoshi'

str = Hoshi::View::HTML5.build {
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
}

puts str
