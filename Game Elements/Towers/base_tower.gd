extends Node2D
class_name BaseTower

var PROJECTILE = PackedScene.new()
#TODO Make towers inherit from 'Tower' class for shooting logic and such when this is tested

var ENEMY_INRANGE_LIST = [] # Has to be up top to be global
var CURRENT_TARGET : Enemy
var FURTHEST : Vector2
var CANFIRE = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (CURRENT_TARGET == null) or (CURRENT_TARGET not in ENEMY_INRANGE_LIST): #If not already shooting or enemy left range
		for enemy in ENEMY_INRANGE_LIST: #Find enemy furthest along in range using Vectors
			
			if enemy.position > FURTHEST:
				FURTHEST = enemy.position # TODO This needs to change to reflect furthest along in level path
				CURRENT_TARGET = enemy # Set that enemy as target
	
	else:
		# Fire at target based on attack speed timer
		if CANFIRE:
			# Initialize arrow projectile with given p0, p1, p2
			var projectile = PROJECTILE.instantiate()
			var zero_vector = Vector2(0, 0)
			var relative_tower_orgin = get_parent().position
			var elevated_midway = zero_vector.lerp((CURRENT_TARGET.position - relative_tower_orgin), 0.5) # switch relative for self.position for magic attack
			elevated_midway.y += projectile.projectile_arc # Elevate
			
			projectile.initialize(zero_vector, elevated_midway, relative_tower_orgin, CURRENT_TARGET) 
			add_child(projectile)
			CANFIRE = false
			$AttackSpeed.start()
			
func _on_range_body_entered(body):
	if body is Enemy: # If they extend the enemy class
		#print("Entered Entered Range: {name}".format({"name": body.name}))
		# Add to enemy in range list
		ENEMY_INRANGE_LIST.append(body)

func _on_range_body_exited(body):
	if body is Enemy: # If they extend the enemy class
		#print("Entered Left Range: {name}".format({"name": body.name}))
		# Remove from range list
		ENEMY_INRANGE_LIST.erase(body)

func _on_attack_speed_timeout():
	CANFIRE = true
