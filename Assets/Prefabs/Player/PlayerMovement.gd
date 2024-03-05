extends CharacterBody2D

@export var moveSpeed = 100
@export var walkingDirection : Vector2 = Vector2(0,0)

@onready var animation_tree = $AnimationTree

func _physics_process(delta):
	var horizontalDir = Input.get_action_strength("right") - Input.get_action_strength("left")
	var verticalDir =  Input.get_action_strength("down") - Input.get_action_strength("up")
	var direction = Vector2(horizontalDir,verticalDir)
	
	velocity = direction * moveSpeed
	
	
	var isMoving = direction != Vector2.ZERO
	
	setWalking(isMoving)
	
	if isMoving:
		setMovingAnimationDirection(direction)
	move_and_slide()

	
func setMovingAnimationDirection(direction):
	animation_tree["parameters/Walk/blend_position"] = direction
	animation_tree["parameters/Idle/blend_position"] = direction
	
func setWalking(isWalking):
	animation_tree["parameters/conditions/isWalking"] = isWalking
	animation_tree["parameters/conditions/isIdle"] = !isWalking
