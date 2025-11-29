extends RigidBody2D

# Add a timer to despawn the projectile after a certain time

func _ready() -> void:
	$DespawnTimer.timeout.connect(queue_free)
	$DespawnTimer.start() # Despawn after 5 seconds

func _on_body_entered(body: Node2D) -> void:
	# Handle collision with other bodies (e.g., player, walls)
	if body.is_in_group("player"):
		# Deal damage to player
		print("Projectile hit player!")
		queue_free() # Despawn on impact
	elif body.is_in_group("environment"):
		# Handle collision with environment (e.g., bounce, stick)
		print("Projectile hit environment!")
		queue_free() # Despawn on impact
