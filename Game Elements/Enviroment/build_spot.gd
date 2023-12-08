extends Node2D

const ARCHERTOWER = preload("res://Game Elements/Towers/archer_tower.tscn")
const MAGETOWER = preload("res://Game Elements/Towers/mage_tower.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuButton.get_popup().id_pressed.connect(_on_menu_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_menu_button_mouse_entered():
	$Sprite2D.modulate = Color(0.0, 1.0, 0.0, 1.0)

func _on_menu_button_mouse_exited():
	$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func _on_menu_button_pressed(id : int = -1) -> void:
	match id:
		0: 
			if Main.GOLD >= 90:
				Main.GOLD -= 90
				UI.update_ui() # This is referencing the global made AUTOLOAD UI scene not the premade child of main
				$Sprite2D.hide()
				$MenuButton.disabled = true
				add_child(ARCHERTOWER.instantiate())
				# This is breaking because the archer tower script is getting x,y from its parent and its parent is now Buildspot not Enviroment
		1: 
			if Main.GOLD >= 100:
				Main.GOLD -= 100
				UI.update_ui() # This is referencing the global made AUTOLOAD UI scene not the premade child of main
				$Sprite2D.hide()
				$MenuButton.disabled = true
				add_child(MAGETOWER.instantiate())
