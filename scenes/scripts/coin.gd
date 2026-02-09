extends Area2D

@onready var animation_player: AnimationPlayer = $pickup_sound/AnimationPlayer
@onready var game_manager: Node = %GameManager


func _on_body_entered(body):
	game_manager.add_point()
	animation_player.play("pickup")
