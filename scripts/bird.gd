extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
const gravity = Vector2(0, 20)
var impulse = Vector2(0, 600)
var initial_position = Vector2(200, 20)

# signals
signal bird_collided

func _ready():
	position = initial_position   
	

func _process(delta):
	# start animatition of the bird
	_animated_sprite.play()
	
	# jumping
	if Input.is_action_just_pressed("jump"):
		velocity -= impulse
	
	# Moving and detecting collisions
	velocity += gravity
	var collision = move_and_collide(velocity * delta)
	
	# TODO: handle game over in the future sending a signal to the main scene
	if collision:
		bird_collided.emit()
		_animated_sprite.stop()
		
func _on_main_game_over() -> void:
	set_process(false)


func _on_main_play_pause(is_game_over) -> void:
	if not is_game_over:
		if is_processing():
			_animated_sprite.stop()
		else:
			_animated_sprite.play()
		set_process(not is_processing())
