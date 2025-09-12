class_name State_Attack extends State

var attacking : bool = false   # flag untuk menandakan apakah player sedang dalam keadaan menyerang

@export var attack_sound : AudioStream   # sound effect untuk serangan
@export_range(1,20,0.5) var decelerate_speed : float = 5.0   # kecepatan player melambat saat menyerang

@onready var walk : State = $"../Walk"   # referensi ke state jalan
@onready var idle : State = $"../Idle"   # referensi ke state diam
@onready var hurt_box : HurtBox = $"../../Interactions/HurtBox"   # area hitbox yang aktif saat menyerang

@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"   # animator utama player
@onready var attack_anim : AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"   # animator khusus efek serangan
@onready var audio : AudioStreamPlayer2D =$"../../Node2D/AudioStreamPlayer2D"   # audio player untuk memutar suara serangan

func Enter() -> void:
	player.UpdateAnimation("attack")   # ganti animasi utama player ke "attack"
	attack_anim.play("attack_" + player.AnimDirection())  
	animation_player.animation_finished.connect(EndAttack)   # sinyal selesai animasi ke fungsi EndAttack()
	
	audio.stream = attack_sound  
	audio.pitch_scale = randf_range(0.9, 1.1)   # randomisasi pitch supaya suara serangan lebih variatif
	audio.play() 
	attacking = true  
	
	await get_tree().create_timer(0.075).timeout  
	hurt_box.monitoring = true   # hurtbox agar bisa mendeteksi tabrakan dengan musuh
	pass

func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)  
	attacking = false   # reset status attacking
	hurt_box.monitoring = false   # nonaktif hurtbox agar tidak selalu menghantam musuh

func Process(delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * delta   #efek melambat saat attack
	
	if attacking == false:   # jika animasi attack sudah selesai
		if player.direction == Vector2.ZERO:   # jika player ngga gerak
			return idle   
		else:   
			return walk  
			
	return null   # jika masih attack, tetap di state attack

# logika update physic
func Physics(delta: float) -> State:
	return null   

# menangani input keyboard, mouse, atau controller
func HandleInput(event: InputEvent) -> State:
	return null  

func EndAttack(_newAnimName : String) -> void:
	attacking = false   # menandakan serangan selesai, memungkinkan transisi state di Process()
