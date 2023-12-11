extends Area2D
class_name Projectile
# TODO GET PROJECTILE TO IGNORE OTHER COLLISIONS BESIDES THE TARGET
var p0 : Vector2
var p1 : Vector2
var p2 : Vector2
var t : float
var count = 0
var CURRENT_TARGET : Enemy
var DAMAGE = -1
var calculated_flightime_pos : Vector2
var projectile_arc = -100 # Represents a negetive y-value at the elevated midpoint
	
func initialize(absolute_orgin, elevated_midway, relative_tower_orgin, c_t): # When initialized we are going to set a target path up (velocity, x/y etc)
	p0 = absolute_orgin #Spawn location of projectile
	p1 = elevated_midway #Arc height position to interpolate
	p2 = relative_tower_orgin # current target position from call time
	CURRENT_TARGET = c_t # Live reference to current target object
	calculated_flightime_pos = CURRENT_TARGET.global_position 
	
func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float): # https://docs.godotengine.org/en/stable/tutorials/math/beziers_and_curves.html#quadratic-bezier 
		var q0 = p0.lerp(p1, t)
		var q1 = p1.lerp(p2, t)
		
		var r = q0.lerp(q1, t) # delta is t
		return r
		
func _ready():
	pass
	
func _process(delta): # This will make the arrow follow its path # Called every frame. 'delta' is the elapsed time since
	#Have last know position
	if is_instance_valid(CURRENT_TARGET): # Need this because the enemy is freed as the next arrow is still calculating its position every frame
		calculated_flightime_pos = CURRENT_TARGET.global_position
	if t < 1.0: # TODO Controlls flight time and smoothness, this needs to change, need to incorperate delta and lerp over a set flight time possibly.
		t += delta
	elif t >= 1.0:
		$CollisionShape2D.disabled = true
		$Sprite2D.hide()
	position = _quadratic_bezier(p0, p1, calculated_flightime_pos-p2, t)
	
	# IMPORTANT!: Hit registration is done in child class
