extends Node

const SPEED_FLOOR = 100
const SPEED_BACKGROUND = SPEED_FLOOR / 2
const WIDTH_FLOOR_SPRITE = 336
const WIDTH_BACKGROUND_SPRITE = 288

@onready var floor_sprites = get_node("FloorSprites").get_children()
@onready var floor_sprites_inital_position = []

@onready var background_sprite = get_node("BackgroundSprite")
@onready var background_sprite_initial_position = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for sprite in floor_sprites:
		floor_sprites_inital_position.append(sprite.position)
		
	background_sprite_initial_position = background_sprite.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for sprite in floor_sprites:
		sprite.position += Vector2(-SPEED_FLOOR * delta, 0)
				
	background_sprite.position += Vector2(-SPEED_BACKGROUND * delta, 0)
		
	if floor_sprites[0].position.x <= -WIDTH_FLOOR_SPRITE / 2:
		for i in len(floor_sprites):
			floor_sprites[i].position = floor_sprites_inital_position[i]
			
	if background_sprite.position.x <= -WIDTH_BACKGROUND_SPRITE:
		background_sprite.position = background_sprite_initial_position


func _on_main_game_over() -> void:
	set_process(false)


func _on_main_play_pause(is_game_over) -> void:
	if not is_game_over:
		set_process(not is_processing())
