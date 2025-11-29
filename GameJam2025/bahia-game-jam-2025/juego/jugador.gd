extends CharacterBody2D

var vida = 100
var speed = 300.0
var jump_speed = -400.0
var is_attacking = false
var tiempo_iframe = 0.75
var iframe = false
var can_attack = false

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	add_to_group("player")
func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction.
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed
	
	if Input.is_action_just_pressed("attack") and !is_attacking:
		is_attacking = true
		$Sprite.play("attack")
		$HitboxGolpe/AttackHitbox.visible = true
		

	move_and_slide()


func _on_sprite_animation_finished() -> void:
	if $Sprite.animation == "attack":
		$HitboxGolpe/AttackHitbox.visible = false
		$Sprite.play("standing")
		is_attacking = false

func take_damage(amount):
	if iframe:
		return
	vida -= amount
	activar_iframe()
	print("HP Jugador:" , vida)
	if vida <= 0:
		die()

func activar_iframe():
	iframe = true
	
	var sprite = $Sprite
	## pestañeo cuando toma hit
	var blink = get_tree().create_timer(tiempo_iframe,true)
	while blink.time_left > 0:
		sprite.modulate.a = 0.3
		await get_tree().create_timer(0.1).timeout
		sprite.modulate.a = 1.0
		await get_tree().create_timer(0.1).timeout
	iframe = false
	sprite.modulate.a = 1.0
	
	
func die():
	get_tree().change_scene_to_file("res://GameOver.tscn")
	
func win():
	get_tree().change_scene_to_file("res://YouWin.tscn")
	
	
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		take_damage(10)
	if body.is_in_group("proyectil"):
		take_damage(15)
	if body.is_in_group("meta"):
		win()


func _on_sprite_frame_changed() -> void:
	if $Sprite.animation == "attack":
		if $Sprite.frame == 2:
			hit_frame()

func hit_frame():
	var bodies = $HitboxGolpe.get_overlapping_bodies()
	for b in bodies:
		if b.is_in_group("enemy"):
			can_attack = true
			if (can_attack):
				b.take_damage(25)
				print("Golpeando enemigo")
				can_attack=false
