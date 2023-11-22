extends CharacterBody2D
class_name Enemy

var SPEED = 0.0
var HEALTH = 0.0
var ARMOR = 0.0
var MAGICARMOR = 0.0
var DAMAGE = 0.0
var LIVESCOST = 0.0

func take_damage(damage):
	HEALTH -= damage
	if HEALTH <= 0:
		die()
		
func die():
	pass # Reward gold, play animation(s), remove from scene, maybe something with barracks unit signal
	
func _ready():
	pass
	
func _physics_process(delta):

	move_and_slide() # Move and slide automatically calls delta, you dont have to pass it
