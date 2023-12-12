extends Node2D
class_name BaseTower

var PROJECTILE = PackedScene.new() # This is pointed to the preload done in the inherited tower class

var ENEMY_INRANGE_LIST = [] # Has to be up top to be global
var CURRENT_TARGET : Enemy
var FURTHEST : float
var CANFIRE = true

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# CHECK FOR FLUSHED MOB (Has been freed) 
	if is_instance_valid(CURRENT_TARGET) and (CURRENT_TARGET is Enemy and CURRENT_TARGET.HEALTH <= 0) or CURRENT_TARGET not in ENEMY_INRANGE_LIST:
		#Break Reference (to prevent reference to nil)
		CURRENT_TARGET = null
		FURTHEST = 0.0
		
		# Find new mob
		for enemy in ENEMY_INRANGE_LIST: #Find enemy furthest along in range using Vectors
				
			if enemy.get_parent().progress_ratio > FURTHEST:
				FURTHEST = enemy.get_parent().progress_ratio
				CURRENT_TARGET = enemy # Set that enemy as target
	
	# Fire at target based on attack speed timer
	if is_instance_valid(CURRENT_TARGET) and CANFIRE and CURRENT_TARGET is Enemy and CURRENT_TARGET in ENEMY_INRANGE_LIST:
		# Initialize arrow projectile with given p0, p1, p2
		var projectile = PROJECTILE.instantiate()
		var zero_vector = Vector2(0, 0)
		var relative_tower_orgin = get_parent().position
		var elevated_midway = zero_vector.lerp((CURRENT_TARGET.global_position - relative_tower_orgin), 0.5) # switch relative for self.position for magic attack
		elevated_midway.y += projectile.projectile_arc # Elevate
			
		projectile.initialize(zero_vector, elevated_midway, relative_tower_orgin, CURRENT_TARGET) 
		add_child(projectile)
		CANFIRE = false
		$AnimationPlayer.play("Fire")
		$AttackSpeed.start()
	
func _on_range_body_entered(body):
	if body is Enemy:
		# Add to enemy in range list
		ENEMY_INRANGE_LIST.append(body)

func _on_range_body_exited(body):
	if body is Enemy:
		# Remove from range list
		ENEMY_INRANGE_LIST.erase(body)

func _on_attack_speed_timeout():
	CANFIRE = true
