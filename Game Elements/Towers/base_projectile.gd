extends Area2D
class_name Projectile

var p0 : Vector2
var p1 : Vector2
var p2 : Vector2
var t : float
var CURRENT_TARGET : Enemy
var DAMAGE = -1
var calculated_flightime_pos : Vector2
var projectile_arc = -100 # Represents a negetive y-value at the elevated midpoint
	
func initialize(absolute_orgin, elevated_midway, relative_tower_orgin, c_t): # When initialized we are going to set a target path up (velocity, x/y etc)
	p0 = absolute_orgin #Spawn location of projectile
	p1 = elevated_midway #Arc height position to interpolate
	p2 = relative_tower_orgin # current target position from call time
	CURRENT_TARGET = c_t # Live reference to current target object
	calculated_flightime_pos = CURRENT_TARGET.position + CURRENT_TARGET.velocity
	
func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float): # https://docs.godotengine.org/en/stable/tutorials/math/beziers_and_curves.html#quadratic-bezier 
		var q0 = p0.lerp(p1, t)
		var q1 = p1.lerp(p2, t)
		
		var r = q0.lerp(q1, t) # delta is t
		return r
		
func _ready():
	pass
	
func _process(delta): # This will make the arrow follow its path # Called every frame. 'delta' is the elapsed time since the previous frame.
	if t < 1.0: # TODO Controlls flight time and smoothness, this needs to change, need to incorperate delta and lerp over a set flight time possibly.
		t += delta
	position = _quadratic_bezier(p0, p1, calculated_flightime_pos-p2, t)
	
	# IMPORTANT!: Hit registration is done in child class
