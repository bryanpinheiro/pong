extends Node2D

signal game_over

signal idle_started
signal ingame_started
signal paused_started
signal stats_started

enum State {IDLE, INGAME, PAUSED, STATS}

var current_state: State

var score_player: int = 0
var score_bot: int = 0
var max_score: int = 3
var idle_elapsed: int = -1:
	set(value):
		idle_elapsed = value
		update_countdown_label()

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var player_score_sound: AudioStreamPlayer = $PlayerScoreSound
@onready var bot_score_sound: AudioStreamPlayer = $BotScoreSound

@onready var result_screen: Panel = %ResultScreen
@onready var results: RichTextLabel = %Results
@onready var countdown_label = %CountdownLabel


func _ready() -> void:
	result_screen.hide()
	change_state(State.IDLE)
	start_countdowmn()
	await get_tree().create_timer(3).timeout
	change_state(State.INGAME)


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
		change_state(State.STATS)

func change_state(new_state: State) -> void:
	current_state = new_state
	
	match new_state:
		State.IDLE:
			idle_started.emit()
		State.INGAME:
			ingame_started.emit()
			countdown_label.hide()
		State.PAUSED:
			paused_started.emit()
		State.STATS:
			stats_started.emit()
		_:
			pass
		

func start_countdowmn() -> void:
	var tween: Tween = create_tween()
	idle_elapsed = 3
	tween.tween_property(self, "idle_elapsed", 0, 3)

func update_countdown_label() -> void:
	if (idle_elapsed != 0):
		countdown_label.text = str(idle_elapsed)
	else:
		countdown_label.text = "GO!"

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()
