extends Control

onready var start_button = $VBoxContainer/CenterContainer2/VBoxContainer/StartButton


func _ready():
	start_button.grab_focus()


func _on_StartButton_pressed():
	get_tree().change_scene("res://Level1.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()
