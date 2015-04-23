SidebarMenuEffects = do ->

	hasParentClass = (e, classname) ->
		if e == document
			return false
		if classie.has(e, classname)
			return true
		e.parentNode and hasParentClass(e.parentNode, classname)

	init = ->
		container = document.getElementById('st-container')
		buttons = Array::slice.call(document.querySelectorAll('#st-trigger-effects > button'))
		eventtype = if mobilecheck() then 'touchstart' else 'click'

		resetMenu = ->
			classie.remove container, 'st-menu-open'
			return

		bodyClickFn = (evt) ->
			if !hasParentClass(evt.target, 'st-menu')
				resetMenu()
				document.removeEventListener eventtype, bodyClickFn
			return

		buttons.forEach (el, i) ->
			effect = el.getAttribute('data-effect')
			el.addEventListener eventtype, (ev) ->
				ev.stopPropagation()
				ev.preventDefault()
				container.className = 'st-container'
				# clear
				classie.add container, effect
				setTimeout (->
					classie.add container, 'st-menu-open'
					return
				), 25
				document.addEventListener eventtype, bodyClickFn
				return
			return
		return

	init()
	return