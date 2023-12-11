extends Projectile

func _ready():
	DAMAGE = 2
	
func _on_body_entered(body):
	if body == CURRENT_TARGET:
		body.update_health(DAMAGE, "Physical")
		queue_free()
