extends Projectile

func _on_body_entered(body):
	if body is Enemy:
		body.update_health(DAMAGE)
		queue_free()
