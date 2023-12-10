extends CharacterBody2D
class_name Enemy

@onready var Path = get_parent()
var previous_global_position : Vector2

var SPEED = 0.0
var HEALTH = 0.0
var MAX_HEALTH = 0.0
var ARMOR = 0.0
var MAGICARMOR = 0.0
var DAMAGE = 0.0
var LIVESCOST : int
var HEALTHBAR : TextureProgressBar
var GOLD = 0

func update_health(value):
	HEALTH += value
	HEALTHBAR.value += value
	
	if HEALTH < MAX_HEALTH:
		HEALTHBAR.show()
	if HEALTH <= 0:
		die()
		
func die():
	# Reward gold, play animation(s), remove from scene, maybe something with barracks unit signal
	$GoldText.show()
	$DeathTimer.start()
	$Sprite2D.hide()
	SPEED = 0
	$Collision.set_deferred("disabled", true)
	Main.GOLD += 20
	UI.update_ui()
	
	#queue_free()
	
func _ready():
	print(GOLD)
	HEALTHBAR = $HealthBar
	$GoldText.text = "+" + str(GOLD)
	
func _process(delta):
	if $GoldText.visible == true:
		$GoldText.position.y -= .15
	previous_global_position = global_position
	
	Path.set_progress(Path.get_progress() + SPEED * delta)
	if Path.get_progress_ratio() == 1:
		Main.LIVES -= LIVESCOST
		UI.update_ui()
		queue_free()
	velocity = (global_position - previous_global_position)
