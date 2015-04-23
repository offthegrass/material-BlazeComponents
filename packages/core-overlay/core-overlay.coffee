class CoreOverlay extends BlazeComponent

	@register 'CoreOverlay'

	onRendered: ->
		parent = @mixinParent().firstNode()
		overlay = parent.querySelector('#overlay')
		if !overlay
			overlay = document.createElement('div')
			overlay.setAttribute 'id', 'overlay'
			parent.appendChild overlay
		@overlay = overlay

	openOverlay: ->
		Classie.add(overlay, 'open')

	closeOverlay: ->
		Classie.remove(overlay, 'open')

	balls: -> 'balls'