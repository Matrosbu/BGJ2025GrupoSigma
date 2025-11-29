extends CharacterBody2D # Or whatever your enemy's root node is

@onready var spawn_proyectile: Node2D = $SpawnProyectil # Path to your projectile spawn point

func _ready() -> void:
	throw_projectile()
	# Example: Start throwing projectiles after a delay or based on enemy behavior
	pass

func throw_projectile() -> void:
	var proyectile_instancia = load("res://juego/ProyectilEnemigoLanzador.tscn").instantiate()
	get_parent().add_child(proyectile_instancia) # Add projectile to a parent node outside the enemy
	
	proyectile_instancia.global_position = spawn_proyectile.global_position
	
	# Calculate direction towards player (if aiming at player)
	# var player_node = get_tree().get_first_node_in_group("player") # Assuming player is in "player" group
	# if player_node:
	#     var direction = (player_node.global_position - muzzle_position.global_position).normalized()
	#     projectile_instance.apply_central_impulse(direction * throw_speed)
		# else:
		# Example: Throw in a fixed direction
	var throw_direction = Vector2(1, 0).rotated(global_rotation) # Throw forward relative to enemy
	proyectile_instancia.apply_central_impulse(Vector2(200,-200))
