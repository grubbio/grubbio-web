jQuery ->

	$('#food-show-calendarToggle').click (event) ->
		event.preventDefault()
		$('#food-show-seasonalCalendar').removeClass 'hidden'