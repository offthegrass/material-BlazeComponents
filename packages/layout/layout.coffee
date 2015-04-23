if Meteor.isServer
	Meteor.startup ->
		Inject.rawModHtml 'addUnresolved', (html) -> # add layout attributes to body
			html = html.replace '<body>', '<body fullbleed layout vertical>'