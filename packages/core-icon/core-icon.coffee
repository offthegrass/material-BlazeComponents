@Icons = new Mongo.Collection null

class CoreIcon extends BlazeComponent
	@register 'CoreIcon'

	template: -> 'CoreIcon'

	onCreated: ->
		self = @
		icons = [
			{name: 'menu', path: 'M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z'}
			{name: 'arrow-back', path: 'M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z'}
			{name: 'add', path: 'M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z'}

		]
		icons.forEach (icon) ->
			Icons.upsert {name: icon.name},
				{
					name: icon.name
					path: icon.path
				}

	path: ->
		field = 'name'
		value = @data().icon
		query = {}
		query[field] = value
		Icons.findOne(query).path



