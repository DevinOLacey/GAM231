extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	#if body.has_node("AnimatedSprite2D"):
		#body.animated_sprite.play("death")
		#await body.animated_sprite.animation_finished
	timer.start()



func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
