extends Enemy

func _init(): # Called on class initialization
	
	SPEED = 15.0
	MAX_HEALTH = 10.0
	HEALTH = 10.0
	ARMOR = 1.0
	MAGICARMOR = 0.0
	DAMAGE = 2.0
	LIVESCOST = 2
	GOLD = 12
	
func _on_area_2d_body_entered(body):
	pass # Fight Enemy

func _on_timer_timeout():
	$GoldText.hide()

func _on_death_timer_timeout():
	$GoldText.hide()
	queue_free()
