class PaperButton extends BlazeComponent

	@register 'PaperButton'

	template: ->
		'PaperButton'

	mixins: ->
		[BlazeComponent.getComponent 'PaperRipple']