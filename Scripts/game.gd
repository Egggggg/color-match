extends Node2D

func _ready():
	GameManager.connect("game_over", self, "_game_over");
	GameManager.connect("points_changed", self, "_points_changed");

func _game_over():
	$GameOver.visible = true;

func _points_changed(new_value):
	var text = "Points: {points}".format({
			"points": floor(new_value)
		})

	$Points.text = text;

func _on_Restart_pressed():
	$GameOver.visible = false;
	GameManager.points = 0;
	GameManager.full = false;

func _on_Exit_pressed():
	get_tree().quit();
