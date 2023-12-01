using Godot;
using System;

public partial class BuildSpot : Node2D
{
	private MenuButton _menuButton;
	private Sprite2D _sprite2D;

	private PackedScene _tower;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_tower = ResourceLoader.Load("res://Game Elements/Towers/archer_tower.tscn") as PackedScene;
		_menuButton = GetNode("MenuButton") as MenuButton;
		_sprite2D = GetNode("Sprite2D") as Sprite2D;
		
		_menuButton.GetPopup().IdPressed += OnIdPressed;
		_menuButton.MouseEntered += MenuButtonOnMouseEntered;
		_menuButton.MouseExited += MenuButtonOnMouseExited;
	}

	private void MenuButtonOnMouseExited()
	{
		_sprite2D.Modulate = new Color(1.0f, 1.0f, 1.0f, 1.0f);
	}

	private void MenuButtonOnMouseEntered()
	{
		_sprite2D.Modulate = new Color(0.0f, 1.0f, 0.0f, 1.0f);
	}

	private void OnIdPressed(long id)
	{
		_sprite2D.Hide();
		_menuButton.Hide();
		switch (id)
		{
			case 0:
				AddChild(_tower.Instantiate());
				break;
			case 1:
				GD.Print("Other is pressed");
				break;
		}
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		
	}

}
