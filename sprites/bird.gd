extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
const gravity = Vector2(0, 10)

func _process(delta):
	# start animatition of the bird
	_animated_sprite.play()
	
	
	# Moving and detecting collisions
	velocity += gravity
	move_and_collide(velocity * delta)
