extends Node

export var speed: int = 100
export var use_timer: bool = false
var enabled = true

func _physics_process(delta: float) -> void:
	yield(get_tree(), "idle_frame")
	
	if get_player():
		if get_parent().can_move:
			look_at_player()
	
	if not enabled:
		return
		
	if get_player():
		if get_parent().can_move:
			get_parent().move_local_x(speed * delta)


func look_at_player() -> void:
	look_at(get_player().position)


func look_at(target: Vector2) -> void:
	get_parent().look_at(target)


func get_player() -> Player:
	return get_parent().get_player()


func _on_Timer_timeout() -> void:
	if use_timer:
		enabled = not enabled
