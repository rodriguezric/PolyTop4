extends Area2D
class_name Bullet

signal hit_enemy
signal destroyed

export (int) var speed = 500 setget set_speed, get_speed
export (int) var damage = 1
onready var polygon := $Polygon2D

func _on_Bullet_body_entered(body: PhysicsBody2D) -> void:
	destroy()


func setColor(color: Color) -> void :
	polygon.color = color


func _physics_process(delta: float) -> void:
	move_local_x(delta * speed)


func _on_Bullet_area_entered(area: Area2D) -> void:
	if area is Enemy:
		emit_signal("hit_enemy", area, damage)
	
	destroy()


func destroy():
	emit_signal("destroyed")
	queue_free()


func set_speed(_speed: int) -> void:
	speed = _speed
	

func get_speed() -> int:
	return speed
