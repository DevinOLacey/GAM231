extends CenterContainer


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_difficulty_pressed() -> void:
	get_tree().paused = false
	get_tree().root.set_meta("came_from_game", true)
	get_tree().change_scene_to_file("res://scenes/difficulty.tscn")


func _on_reset_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
