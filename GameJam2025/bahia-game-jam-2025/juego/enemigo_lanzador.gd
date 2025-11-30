extends CharacterBody2D # Or whatever your enemy's root node is

@onready var spawn_proyectile: Node2D = $SpawnProyectil # Path to your projectile spawn point
var player
var hp = 100
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	add_to_group("enemy")
	await get_tree().create_timer(1.0).timeout
	var timer = Timer.new()
	timer.wait_time = 2
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(throw_projectile)
	throw_projectile()
	# Example: Start throwing projectiles after a delay or based on enemy behavior

func throw_projectile() -> void:
	var proyectile_instancia = load("res://juego/ProyectilEnemigoLanzador.tscn").instantiate()
	get_parent().add_child(proyectile_instancia) # Add projectile to a parent node outside the enemy
	proyectile_instancia.global_position = spawn_proyectile.global_position
	if player:
		var direction = (player.global_position - spawn_proyectile.global_position).normalized()
		proyectile_instancia.apply_central_impulse(direction * 1200)

func take_damage(amount): 
	hp-= amount
	if hp <= 0:
		queue_free()
	print("HP ENEMIGO: ", hp)
