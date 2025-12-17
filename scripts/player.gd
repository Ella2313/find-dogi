extends CharacterBody3D

@onready var camera_mount = $"camera mount"
@onready var animation_player: AnimationPlayer = $varables/AuxScene/AnimationPlayer
@onready var varables: Node3D = $varables

var SPEED = 2.0
const JUMP_VELOCITY = 4.5

var InjuredWalking0_speed = 2.0
var Running0_speed = 4.0

var Running0 = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
@export var mouse_sensitivity := 0.002

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		
		camera_mount.rotate_x(-event.relative.y * mouse_sensitivity)
		
		
		camera_mount.rotation.x = clamp(
			camera_mount.rotation.x,
			deg_to_rad(-80),
			deg_to_rad(80)
		)

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("run"):
		SPEED = Running0_speed
		Running0 = true
	else:
		SPEED = InjuredWalking0_speed
		Running0 = false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Running0:
			if animation_player.current_animation != "Running0":
				animation_player.play("Running0")
		else:
			if animation_player.current_animation != "InjuredWalking0":
				animation_player.play("InjuredWalking0")
			
			varables.look_at(position + direction)
			
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if animation_player.current_animation != "mixamo_com":
			animation_player.play("mixamo_com")
			
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_audio_stream_player_3d_ready() -> void:
	pass # Replace with function body.
