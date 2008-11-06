class NiceHTML::View
	class HTML < self
		tags *%w(html head body 
				 h1 h2 h3 h4 h5 h6

				 div span

				 table tr td
				 script link 

				 canvas
				)
	end
end
