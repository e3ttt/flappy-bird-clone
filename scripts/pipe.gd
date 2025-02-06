extends Node2D

const SPEED = 100 # TODO: on a bigger project, I'd better to put this information on the main script. This is the same speed as the floor.

@onready var pipe_up = get_node("PipeUp")
var x_pos_up = null
var y_pos_up = null
var x_global_pos = null
var y_global_pos = null
var game_over_signal = null # getting value from main
var play_pause_signal = null # getting value from main

func _init(x_up = 0, y_up = -400, x_global = 500, y_global = 400):
	x_pos_up = x_up
	y_pos_up = y_up
	x_global_pos = x_global
	y_global_pos = y_global
	
func _ready():
	pipe_up.position = Vector2(x_pos_up, y_pos_up)
	game_over_signal.connect(_on_main_game_over)
	play_pause_signal.connect(_on_main_play_pause)
	position = Vector2(x_global_pos, y_global_pos)

func _process(delta):
	position += Vector2(-SPEED * delta, 0)

func _on_main_game_over() -> void:
	set_process(false)

func _on_main_play_pause(is_game_over) -> void:
	if not is_game_over:
		set_process(not is_processing())
