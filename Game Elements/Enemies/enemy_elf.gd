extends Enemy
# Reference enemy_class for parent functions and values

func _init(): # Called on class initialization
	
	SPEED = 30.0
	HEALTH = 5.0
	ARMOR = 0.0
	MAGICARMOR = 0.0
	DAMAGE = 2.0
	LIVESCOST = 1.0
	
func _ready(): # Called at end of node setup (children are ready)
	
	velocity.x = SPEED
	
