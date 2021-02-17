extends KinematicBody2D
class_name Player

signal pause_game
signal death
signal hurt

onready var gun = $Gun
onready var animation_player = $AnimationPlayer
onready var shoot_sound = $ShootSound
onready var empty_sound = $EmptySound
onready var hurt_sound = $HurtSound
onready var hurt_timer = $HurtTimer

export (int) var health = 3
export (int) var speed = 3
export (int) var max_bullets: int = 1
export (int) var bullet_speed: int = 350
export (Resource) var bullet_resource
var motion : Vector2
var look : Vector2
var live_bullets : int = 0
var invulnerable : bool = false


func _handle_directions() -> void:
	if Input.is_action_pressed("move_left"):
		motion += Vector2.LEFT

	if Input.is_action_pressed("move_right"):
		motion += Vector2.RIGHT
	
	if Input.is_action_pressed("move_down"):
		motion += Vector2.DOWN
	
	if Input.is_action_pressed("move_up"):
		motion += Vector2.UP


func _handle_attack() -> void:
	if Input.is_action_just_pressed("attack"):
		if can_shoot(): 
			shoot_bullet()
		else:
			empty_sound.play()


func _handle_look() -> void:
	if Input.is_action_pressed("look_left"):
		look.x -= 1
	
	if Input.is_action_pressed("look_right"):
		look.x += 1
		
	if Input.is_action_pressed("look_up"):
		look.y -=1
	
	if Input.is_action_pressed("look_down"):
		look.y +=1
		
	look = look.normalized()
	rotation_degrees = rad2deg(look.angle())


func _handle_pause() -> void:
	if Input.is_action_just_pressed("pause"):
		emit_signal("pause_game")


func _physics_process(delta):
	motion = Vector2()
	
	_handle_directions()
	_handle_attack()
	
	motion = motion.normalized()
	motion *= speed
	
	move_and_collide(motion)
	_handle_look()
	_handle_pause()


func can_shoot():
	return live_bullets < max_bullets


func _on_Bullet_destroyed():
	live_bullets = max(0, live_bullets - 1)


func shoot_bullet() -> void:
	shoot_sound.play()
	live_bullets += 1
	var bullet = bullet_resource.instance()
	bullet.transform = transform
	bullet.set_speed(bullet_speed)
	bullet.connect("hit_enemy", get_parent(), "_on_Bullet_hit_enemy")
	bullet.connect("destroyed", self, "_on_Bullet_destroyed")
	get_parent().add_child(bullet)


func damage(amount: int) -> void:
	if invulnerable:
		return
	
	invulnerable = true
	hurt_timer.start()
	animation_player.play("Hurt")
	
	hurt_sound.play()
	
	health -= amount
	emit_signal("hurt")


func destroy() -> void:
	emit_signal("death")
	queue_free()


func _on_HurtTimer_timeout() -> void:
	invulnerable = false
	
	if health <= 0:
		destroy()
