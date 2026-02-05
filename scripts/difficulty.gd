extends CenterContainer

var came_from_game = false

func _ready() -> void:
	if get_tree().root.has_meta("came_from_game"):
		came_from_game = get_tree().root.get_meta("came_from_game")
		get_tree().root.remove_meta("came_from_game")
		process_mode = Node.PROCESS_MODE_ALWAYS


func _on_easy_pressed() -> void:
	if came_from_game:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_hard_pressed() -> void:
	if came_from_game:
		get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/hard.tscn")
