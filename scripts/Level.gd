extends Node2D

const EnemyScene = preload("res://scenes/Enemy.tscn")
const ChaseBehavior = preload("res://scripts/Behaviors/ChaseBehavior.tscn")

onready var player = $Player
onready var spawn1 = $Spawners/Spawn1
onready var spawn2 = $Spawners/Spawn2
onready var spawn3 = $Spawners/Spawn3
onready var spawn4 = $Spawners/Spawn4
onready var goal = $Goal
onready var hero_hurt_sound = $SoundEffects/HeroHurt
onready var enemy_hurt_sound = $SoundEffects/EnemyHurt

onready var screens = $UI/Screens

var spawners: Array
var spawn_index: int = 0

export var number_of_enemies: int = 5
var live_enemies: int = 0
export var next_level: String = "WIN"

func _ready() -> void:
	spawners = [spawn1, spawn2, spawn3, spawn4]


func _on_Bullet_hit_enemy(enemy: Enemy, damage: int) -> void:
	enemy.damage(damage)


func randomize_spawn_points() -> void:
	randomize()
	spawners.shuffle()


func get_random_spawn_point() -> Vector2:
	if spawn_index == 0:
		randomize_spawn_points()
		print(spawners)

	var spawn_point = spawners[spawn_index].position
	spawn_index = (spawn_index + 1) % len(spawners)

	return spawn_point


func spawn_enemy() -> void:
	var spawn_point = get_random_spawn_point()
	var enemy = EnemyScene.instance()
	enemy.position = spawn_point
	enemy.set_player(player)
	enemy.connect("death", self, "_on_Enemy_death")
	
	add_child(enemy)
	
	var chase_behavior = ChaseBehavior.instance()
	enemy.add_child(chase_behavior)


func _on_SpawnTimer_timeout() -> void:
	if number_of_enemies > 0:
		number_of_enemies -= 1
		live_enemies += 1
		spawn_enemy()


func show_lose_screen() -> void:
	screens.show_lose_screen()


func _on_Player_death() -> void:
	show_lose_screen()


func _on_Enemy_death() -> void:
	live_enemies -= 1
	if live_enemies == 0 and number_of_enemies == 0:
		show_goal()
		

func show_goal() -> void:
	goal.connect("body_entered", self, "_on_Goal_body_entered")
	goal.visible = true


func goto_next_level() -> void:
	if next_level == "WIN":
		print("YOU WIN")
	else:
		get_tree().change_scene("res://" + next_level + ".tscn")

func _on_Goal_body_entered(body: Node) -> void:
	goto_next_level()


func _on_Player_pause_game() -> void:
	screens.show_pause_screen()
