class PaperRipple extends BlazeComponent

	@register 'PaperRipple'

	events: -> [
		'mousedown *': @onMouseDown
		'mouseup *': @onMouseUp
	]

	onRendered: ->
		item = @mixinParent().firstNode()
		wrapper = item.querySelector('.wrapper')
		if !wrapper
			wrapper = document.createElement('div')
			wrapper.setAttribute 'fit', ''
			Classie.add(wrapper, 'wrapper')
			item.appendChild wrapper

	onMouseDown: (e) ->
		# TODO: darken background
		unless @mixinParent().firstNode().hasAttribute('noink')
			item = @mixinParent().firstNode()
			clickX = e.offsetX
			clickY = e.offsetY
			wrapper = item.querySelector('.wrapper')
			ripple = undefined
			width = item.offsetWidth
			height = item.offsetHeight
			size = (if width > height then width else height) * 1.5
			ripple = document.createElement('div')
			Classie.add(ripple, 'ripple')
			ripple.style.opacity = 0.1
			ripple.style.top = clickY + 'px'
			ripple.style.left = clickX + 'px'
			ripple.style.width = 0
			ripple.style.height = 0

			wrapper.appendChild ripple
			newX = clickX - size / 2
			newY = clickY - size / 2
			@animate ripple,
				top: newY + 'px'
				left: newX + 'px'
				width: size + 'px'
				height: size + 'px'

	onMouseUp: (e) ->
		unless @mixinParent().firstNode().hasAttribute('noink')
			self = @
			item = @mixinParent().firstNode()
			wrapper = item.querySelector('.wrapper')
			ripples = undefined
			ripples = wrapper.children
			if wrapper and wrapper.children
				ripples = wrapper.children
				[].forEach.call ripples, (ripple) ->
					# Animate
					self.animate ripple, opacity: 0
					# Remove ripple when animation should be done
					setTimeout (->
						if ripple.parentElement
							ripple.parentElement.removeChild ripple
					), 800


	animate: (obj, properties, duration, easing) ->
		self = @
		data = self.data # should this be a ReactiveVar?
		properties_object = {}
		tweenFunction = undefined
		timeStart = (new Date).getTime()
		if !duration and `duration != 0`
			duration = 800
		if !easing
			easing = 'easeOutExpo'
		tweenFunction = @tween(easing)

		# Put current values into an object
		for prop of properties
			properties_object[prop] = obj.style[prop]

		# Set transition to true
		self.data.transition = true
		animate = setInterval((->
			`var propValue`
			`var prop`
			`var prop`
			timePassed = (new Date).getTime() - timeStart
			if timePassed >= duration
				timePassed = duration

			# Run property update per property
			for prop of properties
				if properties.hasOwnProperty(prop)
					defaultValue = properties_object[prop]
					propValue = properties[prop]
					newValue = null
					convertInt = false
					defaultSuffix = null
					negative = 0
					if `typeof defaultValue == 'string'`
						defaultSuffix = defaultValue.replace(/^\-?[0-9\.]+(.*)$/, '$1')
					defaultValue = parseFloat(defaultValue)
					propValue = parseFloat(propValue)
					# Make the smallest value into 0 and remove the difference from both values, save it in "negative"
					if propValue < 0 or defaultValue < 0
						negative = if propValue < defaultValue then propValue else defaultValue
						defaultValue = defaultValue - negative
						propValue = propValue - negative
					else
						negative = if propValue < defaultValue then propValue else defaultValue
						defaultValue = defaultValue - negative
						propValue = propValue - negative
					if defaultValue > propValue
						newValue = defaultValue - tweenFunction(timePassed, propValue, defaultValue, duration)
						if newValue < propValue
							newValue = propValue
					else if `defaultValue != propValue`
						newValue = tweenFunction(timePassed, defaultValue, propValue, duration)
						if newValue > propValue
							newValue = propValue
					else
						newValue = propValue
					# Remember "negative"? Add it back
					if `negative != 0`
						newValue = newValue + negative
					newValue = newValue + ''
					newValue = newValue.replace(/([0-9]+(\.[0-9]{0,3})?).*/, '$1')
					newValue = parseFloat(newValue)
					if defaultSuffix
						newValue = newValue + defaultSuffix
					obj.style[prop] = newValue
			if timePassed >= duration
				clearInterval animate

				# Make sure all properties are set to the correct final value
				for prop of properties
					if properties.hasOwnProperty(prop)
						propValue = properties[prop]
						propSuffix = null
						if `typeof propValue == 'string'`
							propSuffix = propValue.replace(/^\-?[0-9\.]+(.*)$/, '$1')
						propValue = parseFloat(propValue)
						obj.style[prop] = if propSuffix then propValue + propSuffix else propValue

						# Set transition to false
						self.data.transition = false
		), 24)


	tween: (type) ->
		tweens =
			linear: (t, b, c, d) ->
				c * t / d + b
			easeInQuad: (t, b, c, d) ->
				t /= d
				c * t * t + b
			easeOutQuad: (t, b, c, d) ->
				t /= d
				-c * t * (t - 2) + b
			easeInOutQuad: (t, b, c, d) ->
				t /= d / 2
				if t < 1
					return c / 2 * t * t + b
				t--
				-c / 2 * (t * (t - 2) - 1) + b
			easeInCubic: (t, b, c, d) ->
				t /= d
				c * t * t * t + b
			easeOutCubic: (t, b, c, d) ->
				t /= d
				t--
				c * (t * t * t + 1) + b
			easeInOutCubic: (t, b, c, d) ->
				t /= d / 2
				if t < 1
					return c / 2 * t * t * t + b
				t -= 2
				c / 2 * (t * t * t + 2) + b
			easeInQuart: (t, b, c, d) ->
				t /= d
				c * t * t * t * t + b
			easeOutQuart: (t, b, c, d) ->
				t /= d
				t--
				-c * (t * t * t * t - 1) + b
			easeInOutQuart: (t, b, c, d) ->
				t /= d / 2
				if t < 1
					return c / 2 * t * t * t * t + b
				t -= 2
				-c / 2 * (t * t * t * t - 2) + b
			easeInQuint: (t, b, c, d) ->
				t /= d
				c * t * t * t * t * t + b
			easeOutQuint: (t, b, c, d) ->
				t /= d
				t--
				c * (t * t * t * t * t + 1) + b
			easeInOutQuint: (t, b, c, d) ->
				t /= d / 2
				if t < 1
					return c / 2 * t * t * t * t * t + b
				t -= 2
				c / 2 * (t * t * t * t * t + 2) + b
			easeInSine: (t, b, c, d) ->
				-c * Math.cos(t / d * PI / 2) + c + b
			easeOutSine: (t, b, c, d) ->
				c * Math.sin(t / d * PI / 2) + b
			easeInOutSine: (t, b, c, d) ->
				-c / 2 * (Math.cos(PI * t / d) - 1) + b
			easeInExpo: (t, b, c, d) ->
				c * 2 ** (10 * (t / d - 1)) + b
			easeOutExpo: (t, b, c, d) ->
				c * (-2 ** (-10 * t / d) + 1) + b
			easeInOutExpo: (t, b, c, d) ->
				t /= d / 2
				if t < 1
					return c / 2 * 2 ** (10 * (t - 1)) + b
				t--
				c / 2 * (-2 ** (-10 * t) + 2) + b
			easeInCirc: (t, b, c, d) ->
				t /= d
				-c * (Math.sqrt(1 - t * t) - 1) + b
			easeOutCirc: (t, b, c, d) ->
				t /= d
				t--
				c * Math.sqrt(1 - t * t) + b
			easeInOutCirc: (t, b, c, d) ->
				t /= d / 2
				if t < 1
					return -c / 2 * (Math.sqrt(1 - t * t) - 1) + b
				t -= 2
				c / 2 * (Math.sqrt(1 - t * t) + 1) + b
		tweens[type]
