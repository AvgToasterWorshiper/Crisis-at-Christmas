extends CanvasLayer

#@onready var Game = self.get_parent() # Global Game Reference
# Main flagged as a autoload singleton

func _ready():
	#text = "{difficulty}".format({"difficulty": difficulty})
	update_ui()

func update_ui():
	var main = get_node("/root/Main")
	get_node("MarginContainer/HBoxContainer/VBoxContainer/Gold/Label").text = "Gold: {value}".format({"value": Main.GOLD})
	get_node("MarginContainer/HBoxContainer/VBoxContainer/Lives/Label").text = "Lives: {value}".format({"value": Main.LIVES})
	get_node("MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Label").text = "Wave: {current}/{total}".format({"current": Main.CURRENT_WAVE, "total": Main.TOTAL_WAVES})
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Main.TESTVAL)
	pass
