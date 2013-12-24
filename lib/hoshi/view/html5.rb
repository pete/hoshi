require 'hoshi/view/html'

class Hoshi::View
	class HTML5 < HTML
		dtd! "<!DOCTYPE html>"

		tags *%w(
			a abbr address area article aside audio b base bb
			bdi bdo blockquote body button canvas caption cite
			code col colgroup command data datagrid datalist
			dd del details dfn div dl dt em embed eventsource
			fieldset figcaption figure footer form h1 h2 h3 h4
			h5 h6 head header hgroup html i iframe img ins kbd
			keygen label legend li mark map menu meta meter
			nav noscript object ol optgroup option output p
			param pre progress q ruby rp rt s samp script
			section select small source span strong style
			sub summary sup table tbody td textarea tfoot
			th thead time title tr track u ul var video wbr
		)
		open_tags *%w(br hr link input)
	end
end

