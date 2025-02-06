extends CharacterBody2D

const SPEED = 100 # TODO: on a bigger project, I'd better to put this information on the main script. This is the same speed as the floor.

func _process(delta):
	position += Vector2(-SPEED * delta, 0)

# TODO: This code is basically the same as in bird and floor. Move its logic to main
func _on_main_game_over() -> void:
	print("Game over")
	set_process(false)


# TODO: This code is basically the same as in bird and floor. Move its logic to main
func _on_main_play_pause(is_game_over) -> void:
	if not is_game_over:
		print("Not game over")
		set_process(not is_processing())
