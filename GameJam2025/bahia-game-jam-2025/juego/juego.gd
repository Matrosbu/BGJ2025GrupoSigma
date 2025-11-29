extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_enemy()
	spawn_thrower()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_enemy():
	var enemy = preload("res://juego/Enemigo.tscn").instantiate()
	enemy.global_position = $SpawnEnemigoSimple.global_position
	add_child(enemy)

func spawn_thrower():
	var thrower = preload("res://juego/EnemigoLanzador.tscn").instantiate()
	thrower.global_position = $SpawnThrower.global_position
	add_child(thrower)
