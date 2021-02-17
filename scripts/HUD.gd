extends VBoxContainer

onready var health = $HBoxContainer/VBoxContainer/HBoxContainer/HealthValue
onready var deaths = $HBoxContainer/VBoxContainer/HBoxContainer2/DeathsValue


func _ready() -> void:
	update_health(GameVariables.max_health)
	update_deaths()


func update_health(_health : int) -> void:
	print("updating health " + str(_health))
	health.text = str(_health) + " / " + str(GameVariables.max_health)


func update_deaths() -> void:
	deaths.text = str(GameVariables.deaths)
