extends Area2D

onready var animation_player = $AnimationPlayer

func open_door() -> void:
	animation_player.play("open")
