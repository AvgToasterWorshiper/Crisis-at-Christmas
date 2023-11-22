extends Node2D

const ARROW = preload("res://Game Elements/Towers/tower_arrow.tscn")
#TODO Make towers inherit from 'Tower' class for shooting logic and such when this is tested

var ENEMY_INRANGE_LIST = [] # Has to be up top to be global
var CURRENT_TARGET : Enemy
var FURTHEST : int
var CANFIRE = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (CURRENT_TARGET == null) or (CURRENT_TARGET not in ENEMY_INRANGE_LIST): #If not already shooting or enemy left range
		for enemy in ENEMY_INRANGE_LIST: #Find enemy furthest along in range 
			# TODO Doesnt really matter but this can prob be optimised
			if enemy.position.x > FURTHEST:
				FURTHEST = enemy.position.x # TODO This needs to change to reflect furthest along in level path
				CURRENT_TARGET = enemy # Set that enemy as target
	
	else:
		# Fire at target based on attack speed timer
		if CANFIRE:
			# Initialize arrow projectile with given p0, p1, p2
			var arrow = ARROW.instantiate()
			var absolute_orgin = Vector2(0, 0)
			var elevated_midway = absolute_orgin.lerp((CURRENT_TARGET.position - self.position), 0.5)
			elevated_midway.y = elevated_midway.y + arrow.projectile_arc # Elevate
			var relative_tower_orgin = self.position
			arrow.initialize(absolute_orgin, elevated_midway, relative_tower_orgin, CURRENT_TARGET) # need to start at 0,0 and subtract self position cause its reletive to tower on map 
			add_child(arrow) # TODO these 2 lines need testing
			CANFIRE = false
			$AttackSpeed.start()
			

func _on_range_body_entered(body):
	if body is Enemy: # If they extend the enemy class
		print("Entered Entered Range: {name}".format({"name": body.name}))
		# Add to enemy in range list
		ENEMY_INRANGE_LIST.append(body)

func _on_range_body_exited(body):
	if body is Enemy: # If they extend the enemy class
		print("Entered Left Range: {name}".format({"name": body.name}))
		# Remove from range list
		ENEMY_INRANGE_LIST.erase(body)


func _on_attack_speed_timeout():
	CANFIRE = true
