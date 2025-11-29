extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_enemy()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_enemy():
	var enemy = preload("res://juego/Enemigo.tscn").instantiate()
	enemy.global_position = $SpawnPoint1.global_position
	add_child(enemy)
