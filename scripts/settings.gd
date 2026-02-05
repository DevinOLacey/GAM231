extends Control

var came_from_game = false

@onready var h_slider: HSlider = $PanelContainer/VBoxContainer/HSlider

func _ready() -> void:
	var current_volume_db = AudioServer.get_bus_volume_db(0)
	h_slider.value = db_to_linear(current_volume_db) * 100


func _input(event: InputEvent) -> void:
	if came_from_game and event.is_action_pressed("ui_cancel"):
		_on_back_pressed()
		get_viewport().set_input_as_handled()


func _on_back_pressed() -> void:
	if came_from_game:
		get_tree().paused = false
		get_parent().queue_free()
	else:
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(0, volume_db)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_difficulty_pressed() -> void:
	if came_from_game:
		get_tree().root.set_meta("came_from_game", true)
	get_tree().change_scene_to_file("res://scenes/difficulty.tscn")
