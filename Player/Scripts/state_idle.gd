class_name State_Idle extends State

@onready var walk : State = $"../Walk"
@onready var attack : State = $"../Attack"

# called once when entering the 'idle' state. 
# used to set up initial idle animation or reset variables
func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

# called once when exiting the 'idle' state.
# used to stop old animations or reset conditions
func Exit() -> void:
	pass

# checking whether the player has started moving or remains idle.
# - if player.direction != ZERO → switch to 'walk' state
# - else → keep velocity = 0 so player stays still
func Process(delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

# called every frame in _physics_process.
func Physics(delta: float) -> State:
	return null

# called when handling input events (keyboard, mouse, controller).
func HandleInput(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack
	return null
	
