extends CharacterBody2D


const SPEED = 300
const JUMP_VELOCITY = -750.0

@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#animation 
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "moving"
	else :
		sprite_2d.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d.animation = "jumping" #animation lorsque le sprite ne touche pas le sol

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 11)

	move_and_slide()
	
	var is_left = velocity.x < 0
	sprite_2d.flip_h = is_left
