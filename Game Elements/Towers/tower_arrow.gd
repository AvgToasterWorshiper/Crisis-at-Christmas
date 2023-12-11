extends Projectile

func _on_body_entered(body):
	if body == CURRENT_TARGET:
		body.update_health(DAMAGE)
		queue_free()
