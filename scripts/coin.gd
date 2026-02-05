extends Area2D

@onready var game_manager: Node = %GameManager
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var list = []

func _on_body_entered(body: Node2D) -> void:
	collision_shape_2d.disabled = true
	animated_sprite_2d.visible = false
	if self.name not in list:
		list += [self.name]
		print(self.name)
		game_manager.add_point()
		pickup_sound.play()
		await pickup_sound.finished
		queue_free()
