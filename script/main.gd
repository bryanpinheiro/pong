extends Node2D

signal game_over

var score_player: int = 0
var score_bot: int = 0
var max_score: int = 3

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var player_score_sound: AudioStreamPlayer = $PlayerScoreSound
@onready var bot_score_sound: AudioStreamPlayer = $BotScoreSound

@onready var result_screen: Panel = %ResultScreen
@onready var results: RichTextLabel = %Results


func _ready() -> void:
	result_screen.hide()


func _on_goal_one_body_entered(body: Node2D) -> void:
	body.global_position = Vector2(463, 307)
	score_bot += 1
	update_score()
	bot_score_sound.play()


func _on_goal_two_body_entered(body: Node2D) -> void:
	body.global_position = Vector2(463, 307)
	score_player += 1
	update_score()
	player_score_sound.play()
	
	
func update_score():
	score_label.text = str(score_player) + " x " + str(score_bot)
	if score_player >= max_score or score_bot >= max_score:
		result_screen.show()
		results.text = "%s" % "[center][wave]Vitória![/wave]" if score_player > score_bot else "[center][shake]Derrota![/shake]"
		results.text += "\nFinal Score: %s / %s" % [score_player, score_bot]
		game_over.emit()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
