extends Projectile

func _ready():
	DAMAGE = -2
	projectile_arc = 50
	p1 = Vector2(0, 0).lerp((CURRENT_TARGET.position - self.position), 0.5) # switch relative for self.position for magic attack
	
func _on_body_entered(body):
	if body is Enemy:
		body.update_health(DAMAGE)
		queue_free()
