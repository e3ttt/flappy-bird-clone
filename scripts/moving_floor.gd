extends Node

const SPEED = 100
const WIDTH_SPRITE = 336

@onready var sprites = get_node("FloorSprite").get_children()
@onready var sprites_inital_position = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for sprite in sprites:
		sprites_inital_position.append(sprite.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for sprite in sprites:
		sprite.position += Vector2(-SPEED * delta, 0)
		
	if sprites[0].position.x <= -WIDTH_SPRITE / 2:
		for i in len(sprites):
			sprites[i].position = sprites_inital_position[i]


func _on_main_game_over() -> void:
	set_process(false)


func _on_main_play_pause(is_game_over) -> void:
	if not is_game_over:
		set_process(not is_processing())
