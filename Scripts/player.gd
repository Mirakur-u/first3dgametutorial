extends RigidBody3D

class_name Player

var speed = 70
var vertical_speed_increment = .2
var horizontal_speed_increment = .1

@onready var camera_3d: Camera3D = $"../Camera3D"
@export var camera_z_offset = 5

const JUMP_FORCE = 6

var input : Vector3 = Vector3.ZERO

var is_on_floor = true


func _ready():
	pass
	

func _process(delta: float) -> void:
	camera_3d.position = Vector3(position.x, camera_3d.position.y, position.z - camera_z_offset)


func _physics_process(delta: float) -> void:
	if input.z != 0:
		linear_velocity.z = lerpf(linear_velocity.z, speed , sign(input.z) * vertical_speed_increment * delta)
	if input.x != 0:
		linear_velocity.x = lerpf(linear_velocity.x , speed , sign(input.x) * horizontal_speed_increment * delta)
	
func _input(event: InputEvent) -> void:
	input = Vector3(Input.get_action_raw_strength("left") - Input.get_action_raw_strength("right"), 0, Input.get_action_raw_strength("forward") - Input.get_action_raw_strength("slow"))
	
	if Input.is_action_just_pressed("jump") && is_on_floor:
		apply_central_impulse(Vector3(0,JUMP_FORCE,0))
		is_on_floor = false


func _on_body_entered(body: Node) -> void:
	if body is Floor:
		is_on_floor = true
