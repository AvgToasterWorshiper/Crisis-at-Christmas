extends Projectile

func _on_body_entered(body):
	if body is Enemy:
		body.UpdateHealth(DAMAGE)
		queue_free()
