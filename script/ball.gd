extends CharacterBody2D

var direction: Vector2 = Vector2(-1, -1).normalized()
var speed: float = 500

@onready var hit_sound: AudioStreamPlayer2D = $HitSound

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

	if get_last_slide_collision() != null:
		var normal = get_last_slide_collision().get_normal()
		direction = direction.bounce(normal)
		hit_sound.play()
	

func _on_main_game_over() -> void:
	speed = 0


func _on_main_idle_started():
	speed = 0


func _on_main_ingame_started():
	speed = 500
