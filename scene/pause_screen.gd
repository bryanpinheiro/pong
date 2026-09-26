extends Panel

var is_pausable: bool = true

func _ready() -> void:
	hide()
	#visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("special"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused


func _on_button_pressed() -> void:
	if is_pausable == false:
		return
	get_tree().paused = false
	hide()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")


func _on_main_stats_started():
	is_pausable = false
	set_process_unhandled_input(false)
