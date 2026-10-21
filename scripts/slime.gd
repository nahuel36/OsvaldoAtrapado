extends CharacterBody2D

const SPEED = 80

var direction = 1

@export var initialDir: int
@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
var timerOut: bool

func _ready() -> void:
	direction = initialDir
	timerOut = false
	timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	if ray_cast_2d_left.is_colliding() && is_on_floor():
		direction = 1
		animated_sprite_2d.flip_h = false
	if ray_cast_2d_right.is_colliding() && is_on_floor():
		direction = -1
		animated_sprite_2d.flip_h = true
	elif not is_on_floor() && timerOut:
		direction = -direction
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h				
		velocity += get_gravity() * delta
	 	
	velocity.x = SPEED * direction
	
	
	move_and_slide()


func _on_timer_timeout() -> void:
	timerOut = true
