extends RigidBody

export var damage = 5

func _on_Bullet_body_entered(body):
	if body.is_in_group("Enemy"):
		body.apply_damage(damage)
		queue_free()

func _on_Timer_timeout():
	queue_free()
