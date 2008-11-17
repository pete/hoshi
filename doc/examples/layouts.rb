require 'hoshi'
require 'cgi'

module Layout
	def main_page(t)
		doctype
		html {
			head {
				title t
				script(:type => 'text/javascript') {
					raw "alert(\"Hi, I'm some javascript, I suppose.\");"
				}
			}

			body {
				h1 t, :class => 'page_title'
				yield
			}
		}
	end

	def list_page(t)
		main_page(t) {
			ul {
				yield
			}
		}
	end
end


class Fibonacci < Hoshi::View :xhtml1
	include Layout

	def list_page(n)
		super("Fibonacci: f(0)..f(#{n})") {
			fib_upto(n).map { |i| li i.to_s }
		}
		CGI.pretty(render)
	end

	private

	def fib_upto n
		a = Array.new(n) 

		0.upto(n) { |i|
			a[i] = 
				if i < 2
					1
				else
					a[i - 1] + a[i - 2]
				end
		}

		a
	end
end

puts Fibonacci.new.list_page(10)
