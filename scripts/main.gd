extends Node

@onready var bird_collided = get_node("Bird").bird_collided.connect(on_bird_collided)
@onready var pipe = load("res://scenes/pipe.tscn")

var is_game_over = false

# Signals
signal game_over
signal play_pause(is_game_over: bool)

			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var pipe_instance = pipe.instantiate()
	pipe_instance.game_over_signal = game_over
	pipe_instance.play_pause_signal = play_pause
	pipe_instance.z_index = -1
	add_child(pipe_instance)
	
func on_bird_collided():
	play_pause.emit(true)
	is_game_over = true
	game_over.emit()

func _unhandled_input(event: InputEvent) -> void:
	if not is_game_over:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_ENTER:
				play_pause.emit(false)
