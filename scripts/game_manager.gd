extends Node

const TOTAL_COINS := 13

var score := 0
var slime_dead := false
var game_won := false
var start_time_msec := 0

@onready var slime := get_node_or_null("../slime") as CharacterBody2D
@onready var label := get_node_or_null("../UI/Panel/Label") as Label
@onready var win_overlay := get_node_or_null("../UI/WinOverlay") as CenterContainer
@onready var win_time_label := get_node_or_null("../UI/WinOverlay/CenterContainer/Panel/VBoxContainer/TimeLabel") as Label


func _ready() -> void:
	start_time_msec = Time.get_ticks_msec()

	if is_instance_valid(slime) and slime.has_signal("died"):
		slime.died.connect(_on_slime_died)


func _unhandled_input(event: InputEvent) -> void:
	if game_won:
		return

	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = true
		var settings = load("res://scenes/Settings.tscn").instantiate()
		settings.came_from_game = true
		var canvas_layer = CanvasLayer.new()
		canvas_layer.layer = 999
		canvas_layer.process_mode = Node.PROCESS_MODE_ALWAYS
		canvas_layer.add_child(settings)
		get_tree().current_scene.add_child(canvas_layer)


func add_point() -> void:
	if game_won:
		return

	score += 1

	if is_instance_valid(slime) and not slime.dead:
		slime.scale += Vector2(0.25, 0.25)

	if label:
		label.text = "Coins: %d/%d" % [score, TOTAL_COINS]

	_check_win_condition()


func _on_slime_died() -> void:
	slime_dead = true
	_check_win_condition()


func _check_win_condition() -> void:
	if game_won:
		return
	if score >= TOTAL_COINS and slime_dead:
		win_game()


func win_game() -> void:
	game_won = true

	var elapsed_msec := Time.get_ticks_msec() - start_time_msec
	if win_time_label:
		win_time_label.text = "Time: %s" % _format_elapsed_time(elapsed_msec)

	if win_overlay:
		win_overlay.visible = true

	get_tree().paused = true


func _format_elapsed_time(elapsed_msec: int) -> String:
	var minutes := elapsed_msec / 60000
	var seconds := (elapsed_msec / 1000) % 60
	var centiseconds := (elapsed_msec / 10) % 100
	return "%02d:%02d.%02d" % [minutes, seconds, centiseconds]
