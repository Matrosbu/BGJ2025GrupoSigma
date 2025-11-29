extends CharacterBody2D

var hp = 100
var speed = 80
var player

func _ready():
	player = get_tree().get_first_node_in_group("player")
	add_to_group("enemy")

func _physics_process(_delta):
	if player:
		var dir = (player.global_position - global_position).normalized()
		velocity = dir * speed
		move_and_slide()
func take_damage(amount): 
	hp-= amount
	if hp <= 0:
		queue_free()
	print("HP ENEMIGO: ", hp)
