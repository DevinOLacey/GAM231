extends Control

static var first_launch = true

func _ready() -> void:
	if first_launch:
		# i hate nothing more than ear bvlasting music when launching a game
		var volume_db = linear_to_db(0.33)
		AudioServer.set_bus_volume_db(0, volume_db)
		first_launch = false
		process_mode = Node.PROCESS_MODE_ALWAYS


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/difficulty.tscn") 


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Settings.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
