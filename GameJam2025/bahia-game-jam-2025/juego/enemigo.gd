extends CharacterBody2D

const COOLDOWN = 1.5

var hp = 100
var speed = 200
var player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_direction = 0
var facing_direction = -1
var turning_cooldown = COOLDOWN

func _ready():
	player = get_tree().get_first_node_in_group("player")
	add_to_group("enemy")

func _physics_process(_delta):
	if player:
		player_direction = player.global_position.x - global_position.x
		if(player_direction == 0):
			player_direction = facing_direction
		else:
			player_direction = abs(player_direction) / player_direction

		if(turning_cooldown > 0):
			turning_cooldown -= _delta
		elif(player_direction != facing_direction):
			facing_direction = player_direction
			turning_cooldown = COOLDOWN
		
		velocity.x = facing_direction * speed
		velocity.y += gravity * _delta
		move_and_slide()

func take_damage(amount): 
	hp-= amount
	if hp <= 0:
		queue_free()
	print("HP ENEMIGO: ", hp)
