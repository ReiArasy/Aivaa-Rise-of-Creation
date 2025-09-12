class_name State_Walk extends State

@export var move_speed : float = 100.0
@onready var idle : State = $"../Idle"
@onready var attack : State = $"../Attack"

# called once when entering the 'walk' state. used to  set up initial animation or reset variables
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass

# called once when exiting the 'walk' state. used to stop old animations or reset conditions.
func Exit() -> void:
	pass

# checking whether the player is still moving or has stopped.
func Process(delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	return null

# call frame (_physics_process).
func Physics(delta: float) -> State:
	return null
	
# input event (keyboard, mouse, controller)
func HandleInput(event: InputEvent) -> State:
	if event.is_action_pressed("attack"):
		return attack
	return null
