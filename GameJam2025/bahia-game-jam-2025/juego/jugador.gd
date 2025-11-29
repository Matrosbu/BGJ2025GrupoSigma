extends CharacterBody2D

var speed = 300.0
var jump_speed = -400.0
var is_attacking = false

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
		$Area2D/AttackHitbox.disabled = false
		$Area2D/AttackHitbox.visible = true
		

	move_and_slide()


func _on_sprite_animation_finished() -> void:
	if $Sprite.animation == "attack":
		$Area2D/AttackHitbox.disabled = true
		$Area2D/AttackHitbox.visible = false
		$Sprite.play("standing")
		is_attacking = false
