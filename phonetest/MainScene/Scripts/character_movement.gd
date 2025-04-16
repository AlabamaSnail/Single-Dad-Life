extends CharacterBody3D

# ────────────────────────────────────────────────
#  NODES
# ────────────────────────────────────────────────
@onready var cam : Camera3D = $Camera3D      # adjust the path if your camera node differs

# ── CONSTANTS & TUNABLES ─────────────────────────
@export var gravity       : float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8)
@export var walk_speed    : float = 5.0
@export var sprint_speed  : float = 10.0
@export var jump_velocity : float = 4.5
const MOUSE_SENS          : float = 0.002        # probably stays constant
const SIT_CAM_OFFSET      : float = -0.5

# simple finite‑state machine
enum State { IDLE, WALK, SPRINT, JUMP, SITTING }
var state : State = State.IDLE

# ────────────────────────────────────────────────
#  INITIALISATION
# ────────────────────────────────────────────────
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# ────────────────────────────────────────────────
#  MAIN LOOP
# ────────────────────────────────────────────────
func _physics_process(delta : float) -> void:
	match state:
		State.SITTING:
			# keep gravity so you stay glued to the floor
			if not is_on_floor():
				velocity.y -= gravity * delta
			move_and_slide()
			return

		State.JUMP:
			_state_jump(delta)

		_:
			_state_move(delta)

# ────────────────────────────────────────────────
#  STATE: MOVE (IDLE / WALK / SPRINT)
# ────────────────────────────────────────────────
func _state_move(delta : float) -> void:
	# vertical motion
	if not is_on_floor():
		velocity.y -= gravity * delta

	# jump request
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		state = State.JUMP
		move_and_slide()
		return

	# horizontal input
	var input_dir : Vector2 = Input.get_vector("left", "right", "forwards", "backwards")
	var dir : Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var speed : float = sprint_speed if Input.is_action_pressed("sprint") else walk_speed

	if dir != Vector3.ZERO:
		velocity.x = dir.x * speed
		velocity.z = dir.z * speed
		state = State.SPRINT if speed > walk_speed else State.WALK
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)
		velocity.z = move_toward(velocity.z, 0, walk_speed)
		state = State.IDLE

	move_and_slide()

# ────────────────────────────────────────────────
#  STATE: JUMP
# ────────────────────────────────────────────────
func _state_jump(delta : float) -> void:
	velocity.y -= gravity * delta
	move_and_slide()
	if is_on_floor():
		state = State.IDLE

# ────────────────────────────────────────────────
#  SIT / STAND HELPERS
# ────────────────────────────────────────────────
func _enter_sit(chair_position : Vector3) -> void:
	state = State.SITTING
	velocity = Vector3.ZERO
	transform.origin = chair_position  # Position the player at the chair
	cam.translation.y += SIT_CAM_OFFSET   # optional: lower camera instantly

func _exit_sit() -> void:
	cam.translation.y -= SIT_CAM_OFFSET   # restore camera height
	state = State.IDLE

# ────────────────────────────────────────────────
#  INTERACTION HANDLING (triggered by a chair)
# ────────────────────────────────────────────────
# This function will be called by the chair object to sit the player down
func sit_on_chair(chair_position : Vector3) -> void:
	if state != State.SITTING:
		_enter_sit(chair_position)

# ────────────────────────────────────────────────
#  MOUSE LOOK (camera rotation based on mouse)
# ────────────────────────────────────────────────
func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if state != State.SITTING:  # Allow looking around if not sitting
			rotate_y(-event.relative.x * MOUSE_SENS)
			cam.rotate_x(-event.relative.y * MOUSE_SENS)
			cam.rotation.x = clamp(cam.rotation.x, -PI / 2, PI / 2)
