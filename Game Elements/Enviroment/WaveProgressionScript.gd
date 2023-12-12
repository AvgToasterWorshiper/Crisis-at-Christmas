extends Node2D

var active_group = 1
var total_groups = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is Path2D:
			total_groups += 1
	get_node("Group" + str(active_group)).process_mode = PROCESS_MODE_INHERIT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_wave_timer_timeout():
	active_group += 1
	
	if active_group > total_groups:
		# Next wave
		UI.get_node("MarginContainer/HBoxContainer/VBoxContainer3/Label").text = ("Wave " + str(Main.CURRENT_WAVE) + " Over!")
		$BreakTime.start()
	else:
		if is_instance_valid(get_node("Group" + str(active_group))):
			get_node("Group" + str(active_group)).process_mode = PROCESS_MODE_INHERIT

func _on_break_time_timeout():
	if Main.CURRENT_WAVE < Main.TOTAL_WAVES:
		Main.CURRENT_WAVE += 1
	elif Main.CURRENT_WAVE == Main.TOTAL_WAVES:
		UI.get_node("MarginContainer/HBoxContainer/VBoxContainer3/Label").text = ("All Waves Done!")
	UI.update_ui()
	UI.get_node("MarginContainer/HBoxContainer/VBoxContainer3/Label").text = ("Wave " + str(Main.CURRENT_WAVE) + " Begin!")
	$BreakTime.stop()
	$WaveTimer.stop()
	if Main.CURRENT_WAVE <= Main.TOTAL_WAVES:
		get_parent().get_node("Wave" + str(Main.CURRENT_WAVE)).process_mode = PROCESS_MODE_INHERIT
