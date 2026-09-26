extends CharacterBody2D

# clicar na Ball e arrastar segurando ctrl.
@onready var ball: CharacterBody2D = $"../Ball"

func _physics_process(delta: float) -> void:
	var ball_direction = global_position.direction_to(ball.global_position)
	
	var speed = 400
	var random = randi_range(1, 100)
	if random <= 5:
		speed = 0
	
	if ball_direction.y >= 0:
		velocity.y = lerpf(velocity.y, speed, 6 * delta)
	else:
		velocity.y = lerpf(velocity.y, speed * -1, 6 * delta)
		
	move_and_slide()


func _on_main_game_over() -> void:
	set_physics_process(false)


func _on_main_idle_started():
	set_physics_process(false)


func _on_main_ingame_started():
	set_physics_process(true)
