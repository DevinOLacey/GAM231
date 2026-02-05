extends Area2D

@onready var pickup: AudioStreamPlayer2D = $pickup

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_power"):
		body.add_power()
		pickup.play()
		visible = false
		$CollisionShape2D.disabled = true
		await pickup.finished
		queue_free()
