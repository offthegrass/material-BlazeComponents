class PaperFab extends BlazeComponent

	@register 'PaperFab'

	template: ->
		'PaperFab'

	mixins: ->
		[BlazeComponent.getComponent 'PaperRipple']