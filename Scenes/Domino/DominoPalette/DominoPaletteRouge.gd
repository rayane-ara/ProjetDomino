extends Node2D

# --------- Signals ---------
signal click_domino_rouge
signal supp_domino_rouge(id,parent)
signal select_domino_rouge(id)

# --------- Signal handlers ---------
func _on_DominoPaletteRouge_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		emit_signal("click_domino_rouge")
		emit_signal("select_domino_rouge",get_index())
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.is_pressed():
		emit_signal("supp_domino_rouge",get_index(),get_parent())


# --------- Helper functions ---------
func input(event):
	_on_DominoPaletteRouge_input_event(null,event,null)

func get_rect(where):
	var sprite = get_children()[1]
	var size = Vector2()
	if sprite.texture:
		size = sprite.texture.get_size() * sprite.scale * 0.8 + Vector2(-12, 10)
		if where != null:
			size = size * 0.18
		return Rect2(global_position - Vector2(2,2)- (size/1.25) / 2 , size / 1.18)
