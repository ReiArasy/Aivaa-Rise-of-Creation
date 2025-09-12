class_name State extends Node

# Reference ke Player yang sedang menggunakan state ini.
# Karena static, variabel ini bisa diakses dari semua turunan State.
static var player: Player

# dipanggil sekali ketika state ini pertama kali dimasuki.
# set animasi awal, reset timer, dll.
func Enter() -> void:
	pass

#berhenti animasi lama, reset variabel.
func Exit() -> void:
	pass

# what happens during the _process update in this state?
func Process(delta: float) -> State:
	return null

# what happens during the _physics_process update in this state?
func Physics(delta: float) -> State:
	return null
	
# what happens with input events in this state?
func HandleInput(event: InputEvent) -> State:
	return null
