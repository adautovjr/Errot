extends Area2D

func _on_area_entered(area):
	var parent = area.get_parent()
	if parent is InteractableObject:
		var this = get_parent()
		this.interactions_in_range.insert(0, parent)
		#this.get_node("InteractionLabel").text = parent.interaction_label
		this.get_node("Indicator").show()
		

func _on_area_exited(area):
	var this = get_parent()
	this.interactions_in_range.erase(area.get_parent())
	if (this.interactions_in_range.size() > 0):
		#this.get_node("InteractionLabel").text = this.interactions_in_range[0].interaction_label
		this.get_node("Indicator").show()
		pass
	else:
		#this.get_node("InteractionLabel").text = ""
		this.get_node("Indicator").hide()
		pass
