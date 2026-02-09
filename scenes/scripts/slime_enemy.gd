extends Node2D

const SPEED = 60

var direction = 1

var is_dead = false
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
		
	position.x += direction * SPEED * delta

func _on_body_entered(body):
	
	if body.name == "Player" and is_dead == false and body.took_damage == false:
		body.respawn()

func _on_stomp_body_entered(body):
	if body.name == "Player" and is_dead == false:
		
		print("Enemy", global_position.y)
		print("Player", str(int(body.global_position.y)))
		
		if int(body.global_position.y +2) < int(global_position.y):
			
			animated_sprite_2d.visible = false
			is_dead = true
			audio_stream_player_2d.play()
			body.bounce_after_stomp()
		queue_free()
		
