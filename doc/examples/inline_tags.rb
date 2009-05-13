require 'hoshi'

puts(Hoshi::View(:html4) {
	doc {
		head {
			title "Hello, world!"
			link :rel => 'stylesheet', :href => '/css/hoshi.css'
		}

		body {
			h1 "Hello, world!"
			p "This is a greeting to the world."
			p { 
				"And #{_a 'this', :href => '/'} is an inline tag, prefixed "\
					"by '_'."
			}

		}
	}
})
