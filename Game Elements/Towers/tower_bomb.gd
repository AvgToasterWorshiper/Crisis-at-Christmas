extends Projectile

var already_hit = []

func _ready():
	DAMAGE = 3
	projectile_arc = -200
	
func _on_body_entered(body):
	if body not in already_hit:
		body.update_health(DAMAGE, "Physical")
		already_hit.append(body)

func _process(delta): # This will make the arrow follow its path # Called every frame. 'delta' is the elapsed time since
	#Have last know position
	if is_instance_valid(CURRENT_TARGET): # Need this because the enemy is freed as the next arrow is still calculating its position every frame
		calculated_flightime_pos = CURRENT_TARGET.global_position
	else:
		calculated_flightime_pos = last_known_position # TODO MIGHT NOT NEED
		
	if t < 1.0: # TODO Controlls flight time and smoothness, this needs to change, need to incorperate delta and lerp over a set flight time possibly.
		t += delta
		position = _quadratic_bezier(p0, p1, calculated_flightime_pos-p2, t)
	elif t >= 1.0 and $Explosion.is_stopped():
		$Sprite2D.hide()
		#Expload
		$ExplosionSprite.show()
		$ExplosionCollision.disabled = false
		$ExplosionCollision.show()
		$Explosion.start()

func _on_explosion_timeout():
	$ExplosionCollision.disabled = true
	$ExplosionCollision.hide()
	queue_free()
