extends Node2D

var GOLD = 200
var LIVES = 20
var TOTAL_WAVES = 7
var CURRENT_WAVE = 1
var TESTVAL = 123

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if LIVES <= 0:
		get_tree().quit()
