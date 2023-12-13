using Godot;
using System;
using System.IO;

[GlobalClass]
public abstract partial class Enemy : CharacterBody2D
{
	protected PathFollow2D Path;
	protected float Speed;
	protected float Health;
	protected float MaxHealth;
	protected float Armor;
	protected float MagicArmor;
	protected float Damage;
	protected int LivesCost;
	protected int GoldReward;
	protected TextureProgressBar HealthBar;

	private Vector2 _previousGlobalPosition;
	
	protected Enemy(float speed, float maxHealth, float armor, float magicArmor, float damage, int livesCost, int goldReward)
	{
		Speed = speed;
		Health = maxHealth;
		MaxHealth = maxHealth;
		Armor = armor;
		MagicArmor = magicArmor;
		Damage = damage;
		LivesCost = livesCost;
		GoldReward = goldReward;
	}

	public void UpdateHealth(float value)
	{
		Health += value;
		HealthBar.Value += value;
		if (Health < MaxHealth)
		{
			HealthBar.Show();
		}

		if (Health <= 0)
		{
			Die();
		}
		
	}

	private void Die()
	{
		var main = GetNode("/root/Main");
		var ui = GetNode("/root/UI");
		// Reward gold, play animation, remove from scene, maybe something with barracks unit signal
		var gold = (int)main.Get("GOLD");
		gold += GoldReward;
		main.Set("GOLD", gold);
		ui.Call("update_ui");
		QueueFree();
	}

	public override void _PhysicsProcess(double delta)
	{
		MoveAndSlide();
	}

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		Velocity = new Vector2(Speed, 0f);
		
		// Is it bad practice to hardcode the progressbar name? Yes. Does it still work? Also yes!
		HealthBar = GetNode<TextureProgressBar>("HealthBar");
		Path = GetParent() as PathFollow2D;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		_previousGlobalPosition = GlobalPosition;

		Path.Progress += Speed * (float)delta;
		if (Path.ProgressRatio == 1f)
		{
			var main = GetNode("/root/Main");
			var ui = GetNode("/root/UI");
			var lives = (int)main.Get("LIVES");
			main.Set("LIVES", lives - LivesCost);
			ui.Call("update_ui");
		}
	}
}
