extends CharacterBody3D

@onready var stamina_audio: AudioStreamPlayer = $"../stamina/AudioStreamPlayer"
@onready var camera_3d = $Camera3D
@onready var andar: AudioStreamPlayer3D = $andar as AudioStreamPlayer3D
@onready var lanterna = $Camera3D/SpotLight3D
@onready var mao_item = $Mão/Sketchfab_Scene
@onready var stamina_bar = $"../stamina/ProgressBar"
@onready var Clickdalanterna = $"click da lanterna"
@onready var som = $coleta

var SPEED = 8
const WALK_SPEED = 8
const RUN_SPEED = 12

const JUMP_VELOCITY = 6
const CAMERA_SENS = 0.003

var stamina := 100.0
const MAX_STAMINA := 100.0
const STAMINA_DRAIN := 40
const STAMINA_RECOVER := 20

var pode_correr := true
var recuperando := false

var lanterna_ativa = false
var possui_lanterna := false

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	add_to_group("player")
	

	if mao_item:
		mao_item.visible = false

	if lanterna:
		lanterna.visible = false
		lanterna.light_energy = 0
	else:
		print("LANTERNA NÃO ENCONTRADA NO CAMINHO!")
	
func _input(event):
	if event.is_action_pressed("ui_cancel"): get_tree().quit()
	if event.is_action_pressed("desliga ligar"):
		toggle_lanterna()
	
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * CAMERA_SENS
		rotation.x -= event.relative.y * CAMERA_SENS
		rotation.x = clamp(rotation.x, -0.5, 1.2)
		
	if event.is_action_pressed("e ou d") and possui_lanterna:
		lanterna.visible = !lanterna.visible
		mao_item.visible = lanterna.visible

	if not lanterna.visible:
		lanterna.light_energy = 0
		

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		andar.stop()

	var input_dir = Input.get_vector("move3", "move4", "move1", "move2")

	var correndo = Input.is_action_pressed("corrrer") \
	and input_dir != Vector2.ZERO \
	and pode_correr

	if correndo:
		SPEED = RUN_SPEED
		stamina -= STAMINA_DRAIN * delta
	else:
		SPEED = WALK_SPEED

	if not recuperando:
		stamina += STAMINA_RECOVER * delta

	stamina = clamp(stamina, 0.0, MAX_STAMINA)

	stamina_bar.value = stamina
	stamina_bar.visible = stamina < MAX_STAMINA or correndo

	if stamina <= 0.0 and pode_correr:
		pode_correr = false
		recuperando = true
		SPEED = WALK_SPEED

		stamina_audio.play()

		recuperar_stamina()
	

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED

		if not andar.playing:
			andar.play()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		andar.stop()

	move_and_slide()
	
	
	
func equipar_lanterna():
	possui_lanterna = true

	mao_item.visible = true
	lanterna.visible = true
	lanterna_ativa = false
	lanterna.light_energy = 0

	som.play()
	


func toggle_lanterna():
	if not lanterna.visible:
		return

	lanterna_ativa = !lanterna_ativa
	lanterna.light_energy = 3.0 if lanterna_ativa else 0.0
	Clickdalanterna.play()
	
func recuperar_stamina():
	await get_tree().create_timer(14.0).timeout

	recuperando = false
	pode_correr = true
