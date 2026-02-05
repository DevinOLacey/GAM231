extends AudioStreamPlayer2D


func _ready() -> void:
	# Make sure music continues playing even when game is paused
	process_mode = Node.PROCESS_MODE_ALWAYS
