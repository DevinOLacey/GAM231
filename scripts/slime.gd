extends CharacterBody2D

signal died

const SPEED = 60
const bounce_velocity = -350.0

var dead := false

var direction = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stomp_area: Area2D = $StompArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead:
		return
	
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = true
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
	
	position.x += direction *SPEED * delta
# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0
	# Actually apply velocity
	move_and_slide()

func _on_stomp_area_body_entered(body: Node) -> void:
	if dead:
		return
		
	if body.name == "Player" and body.global_position.y < global_position.y:
		if body.power:
			_die()
			body.velocity.y = bounce_velocity
		else:
			$killzone._on_body_entered(body)

func _ready() -> void:
	stomp_area.body_entered.connect(_on_stomp_area_body_entered)
	animation_player.animation_finished.connect(_on_animation_finished)
	

func _die() -> void:
	if dead:
		return
	dead = true
	velocity = Vector2.ZERO
	$CollisionShape2D.disabled = true
	$killzone/CollisionShape2D.disabled = true
	$StompArea/CollisionShape2D.disabled = true
	animation_player.play("death")

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "death":
		died.emit()
		queue_free()
