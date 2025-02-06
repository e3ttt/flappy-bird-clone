extends Node

@onready var bird_collided = get_node("Bird").bird_collided.connect(on_bird_collided)

# Signals
signal game_over
signal play_pause(is_game_over: bool)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			play_pause.emit(false)
			
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_bird_collided():
	play_pause.emit(true)
	game_over.emit()
