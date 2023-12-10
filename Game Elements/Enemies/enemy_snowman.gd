extends Enemy
# Reference enemy_class for parent functions and values

func _init(): # Called on class initialization
	
	SPEED = 30.0
	MAX_HEALTH = 4.0
	HEALTH = 4.0
	ARMOR = 0.0
	MAGICARMOR = 0.0
	DAMAGE = 2.0
	LIVESCOST = 1
	GOLD = 20
	
func _on_area_2d_body_entered(body):
	pass # Fight Enemy

func _on_timer_timeout():
	$GoldText.hide()

func _on_death_timer_timeout():
	$GoldText.hide()
	queue_free()
