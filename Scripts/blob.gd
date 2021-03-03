extends Sprite

func _ready():
	modulate = Color.from_hsv(randf(), .5 + (.25 * randf()), .85 + (.1 * randf()));
