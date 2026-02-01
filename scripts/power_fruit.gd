extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_power"):
		body.add_power()
		queue_free()
