extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_button_mouse_entered():
	$Sprite2D.modulate = Color(0.0, 1.0, 0.0, 1.0)


func _on_menu_button_mouse_exited():
	$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 1.0)
