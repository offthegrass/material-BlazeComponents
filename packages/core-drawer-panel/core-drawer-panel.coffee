class CoreDrawerPanel extends BlazeComponent

	@register 'CoreDrawerPanel'

	template: -> 'CoreDrawerPanel'

	mixins: ->
		[BlazeComponent.getComponent 'CoreOverlay']

	events: -> [
		'click [open-drawer]': @openDrawer
		'click #overlay': @closeDrawer
	]

	openDrawer: ->
		Classie.add(@firstNode(), 'open')
		@callFirstWith null, 'openOverlay'

	closeDrawer: ->
		if Classie.has(@firstNode(), 'open')
			Classie.remove(@firstNode(), 'open')
			@callFirstWith null, 'closeOverlay'