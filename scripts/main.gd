extends Node

@onready var bird_collided = get_node("Bird").bird_collided.connect(on_bird_collided)
@onready var pipe = load("res://scenes/pipe.tscn")
@onready var SCREEN_WIDTH = get_viewport().content_scale_size.x * (1.1)

var is_game_over = false
var is_paused = false

# Signals
signal game_over
signal play_pause(is_game_over: bool)

			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	print(SCREEN_WIDTH)
	
func on_bird_collided():
	play_pause.emit(true)
	is_game_over = true
	game_over.emit()

func _unhandled_input(event: InputEvent) -> void:
	if not is_game_over:
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_ENTER:
				play_pause.emit(false)
				is_paused = not is_paused


func _on_spawn_pipe_timer_timeout() -> void:
	if is_game_over:
		$SpawnPipeTimer.stop()
	elif not is_paused:
		var pipe_instance = pipe.instantiate()
		pipe_instance.x_global_pos = SCREEN_WIDTH
		pipe_instance.game_over_signal = game_over
		pipe_instance.play_pause_signal = play_pause
		pipe_instance.z_index = -1
		
		# Adding variation in height
		pipe_instance.y_global_pos = pipe_instance.y_global_pos + randi_range(-50, 50)
		
		add_child(pipe_instance)
		
		# Adding variation to the time when the pipes are spawned
		$SpawnPipeTimer.wait_time = 1 + randf_range(0, 1)
