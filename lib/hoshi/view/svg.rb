class Hoshi::View
	class SVG < self
		# camelCase looks awful on method names, and we can't have
		# hyphenated ones, so we start with a tag list from MDN:
		# https://developer.mozilla.org/en-US/docs/Web/SVG/Element
		tag_list = %w(
			a altGlyph altGlyphDef altGlyphItem animate animateColor
			animateMotion animateTransform circle clipPath color-profile
			cursor defs desc ellipse feBlend feColorMatrix
			feComponentTransfer feComposite feConvolveMatrix
			feDiffuseLighting feDisplacementMap feDistantLight feFlood
			feFuncA feFuncB feFuncG feFuncR feGaussianBlur feImage feMerge
			feMergeNode feMorphology feOffset fePointLight
			feSpecularLighting feSpotLight feTile feTurbulence filter font
			font-face font-face-format font-face-name font-face-src
			font-face-uri foreignObject g glyph glyphRef hkern image line
			linearGradient marker mask metadata missing-glyph mpath path
			pattern polygon polyline radialGradient rect script set stop
			style svg switch symbol text textPath title tref tspan use view
			vkern
		)

		self_closing_tags *tag_list.grep(/^[a-z]+$/i)
		tag_list.grep(/[A-Z]/).each { |camel|
			alias_method camel.
				gsub(/([a-z])([A-Z])/) { "#{$1}_#{$2}" }.downcase.to_sym,
				camel.to_sym
		}
		tag_list.grep(/-/).each { |hyphen|
			define_method(hyphen.gsub('-', '_')) { |*opts,&b|
				if b
					tag hyphen, :self, *opts, &b
				else
					tag hyphen, :self, *opts
				end
			}
		}

		dtd! '<?xml version="1.0" encoding="UTF-8"?>\n' \
			'<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" '\
			'"http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">'

		def self.content_type
			"image/svg+xml"
		end
	end
end
