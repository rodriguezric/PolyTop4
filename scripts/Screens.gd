extends CanvasLayer

onready var hud = $HUD

onready var pause_screen = $PauseScreen
onready var lose_screen = $LoseScreen
onready var win_screen = $WinScreen

onready var pause_button = $PauseScreen/VBoxContainer2/CenterContainer2/VBoxContainer/ContinueButton
onready var lose_button = $LoseScreen/VBoxContainer/CenterContainer2/VBoxContainer/TryAgainButton
onready var win_button = $WinScreen/VBoxContainer/CenterContainer2/VBoxContainer/MenuButton

onready var win_label := $WinScreen/CenterContainer/WinLabel

func show_win_screen() -> void:
	hide_all_screens()
	win_label.text = "YOU WIN!\nYOU DIED "+ str(GameVariables.deaths) +" TIMES!"
	
	win_screen.visible = true
	win_button.grab_focus()


func show_lose_screen() -> void:
	hide_all_screens()
	lose_screen.visible = true
	lose_button.grab_focus()


func show_pause_screen() -> void:
	hide_all_screens()
	pause_screen.visible = true
	pause_button.grab_focus()
	get_tree().paused = true


func hide_all_screens() -> void:
	win_screen.visible = false
	lose_screen.visible = false
	pause_screen.visible = false


func update_health(health : int) -> void:
	hud.update_health(health)


func update_deaths() -> void:
	hud.update_deaths()


func _on_ContinueButton_pressed() -> void:
	hide_all_screens()
	get_tree().paused = false


func _on_MenuButton_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene("res://Main.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()


func _on_TryAgainButton_pressed() -> void:
	get_tree().reload_current_scene()
