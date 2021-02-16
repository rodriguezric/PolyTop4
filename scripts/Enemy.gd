extends Area2D
class_name Enemy

signal death

onready var hurt_sound = $HurtSound

export var hp: int = 2 setget set_hp, get_hp
export var attack: int = 1
var player setget set_player, get_player


func get_player() -> Player:
	return player


func set_player(_player: Player) -> void:
	player = _player


func get_hp() -> int:
	return hp


func set_hp(_hp: int) -> void:
	hp = _hp


func damage(amount: int) -> void:
	hurt_sound.play()
	hp -= amount
	if hp <= 0:
		destroy()


func destroy():
	emit_signal("death")
	queue_free()
	


func _on_Enemy_body_entered(body: Node) -> void:
	if body is Player:
		body.damage(attack)
		
	if body.is_in_group("wall"):
		print("hitting wall")
