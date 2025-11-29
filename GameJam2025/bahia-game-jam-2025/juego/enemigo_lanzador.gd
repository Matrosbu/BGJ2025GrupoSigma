extends CharacterBody2D # Or whatever your enemy's root node is

@onready var spawn_proyectile: Node2D = $SpawnProyectil # Path to your projectile spawn point
var player
var hp = 100
func _ready() -> void:
<<<<<<< HEAD
	$AttackTimer.start()
=======
	player = get_tree().get_first_node_in_group("player")
	add_to_group("enemy")
	await get_tree().create_timer(1.0).timeout
	var timer = Timer.new()
	timer.wait_time = 5
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(throw_projectile)
	throw_projectile()
	# Example: Start throwing projectiles after a delay or based on enemy behavior
>>>>>>> 400b69bec0678edcd0a93c2c6997d63cbe4d5913
	pass

func throw_projectile() -> void:
	var proyectile_instancia = load("res://juego/ProyectilEnemigoLanzador.tscn").instantiate()
	get_parent().add_child(proyectile_instancia) # Add projectile to a parent node outside the enemy
	proyectile_instancia.global_position = spawn_proyectile.global_position
<<<<<<< HEAD
	
	# Calculate direction towards player (if aiming at player)
	# var player_node = get_tree().get_first_node_in_group("player") # Assuming player is in "player" group
	# if player_node:
	#     var direction = (player_node.global_position - muzzle_position.global_position).normalized()
	#     projectile_instance.apply_central_impulse(direction * throw_speed)
		# else:
		# Example: Throw in a fixed direction
	var throw_direction = Vector2(1, 0).rotated(global_rotation) # Throw forward relative to enemy
	proyectile_instancia.apply_central_impulse(Vector2(200,-200))


func _on_attack_timer_timeout() -> void:
	throw_projectile()
	pass # Replace with function body.
=======
	if player:
		var direction = (player.global_position - spawn_proyectile.global_position).normalized()
		proyectile_instancia.apply_central_impulse(direction * 400)

func take_damage(amount): 
	hp-= amount
	if hp <= 0:
		queue_free()
	print("HP ENEMIGO: ", hp)
>>>>>>> 400b69bec0678edcd0a93c2c6997d63cbe4d5913
