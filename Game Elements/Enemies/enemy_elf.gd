extends Enemy
# Reference enemy_class for parent functions and values

func _init(): # Called on class initialization
	
	SPEED = 30.0
	MAX_HEALTH = 4.0
	HEALTH = 4.0
	ARMOR = 0.0
	MAGICARMOR = 0.0
	DAMAGE = 2.0
	LIVESCOST = 1.0
	
func die():
	# Reward gold, play animation(s), remove from scene, maybe something with barracks unit signal
	Main.GOLD += 20
	UI.update_ui()
	queue_free()
	
func _ready(): # Called at end of node setup (children are ready)
	
	velocity.x = SPEED
	HEALTHBAR = $HealthBar
	
func _on_area_2d_body_entered(body):
	pass
