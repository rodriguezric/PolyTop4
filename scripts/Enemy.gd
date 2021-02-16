extends Area2D
class_name Enemy

signal death

onready var animation_player = $AnimationPlayer
onready var hurt_sound = $HurtSound
onready var hurt_timer = $HurtTimer
onready var death_timer = $DeathTimer


export var hp: int = 2 setget set_hp, get_hp
export var attack: int = 1
var player setget set_player, get_player
var can_move : bool = true
var dead : bool = false

func _ready() -> void:
	animation_player.play("idle")


func get_player() -> Player:
	return player


func set_player(_player: Player) -> void:
	player = _player


func get_hp() -> int:
	return hp


func set_hp(_hp: int) -> void:
	hp = _hp


func _handle_death() -> void:
	if hp <= 0:
		if not dead:
			animation_player.play("death")
			death_timer.start()
		dead = true


func damage(amount: int) -> void:
	if dead:
		return

	can_move = false
	animation_player.play("hurt")
	hurt_timer.start()
	
	hurt_sound.play()
	hp -= amount
	_handle_death()


func destroy():
	emit_signal("death")
	queue_free()


func _on_Enemy_body_entered(body: Node) -> void:
	if body is Player:
		body.damage(attack)
		
	if body.is_in_group("wall"):
		print("hitting wall")


func _on_HurtTimer_timeout() -> void:
	can_move = true


func _on_DeathTimer_timeout() -> void:
	destroy()
