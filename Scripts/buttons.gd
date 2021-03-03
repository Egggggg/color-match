extends Control

const TIMEOUT = 1;

var buttons = [0, 0, 0, 0, 0, 0, 0, 0];

func _pressed(color, button):
	var h = color.h;

	GameManager.attack(h);

	get_node("TextureButton{button}".format({
			"button": button
		})).disabled = true;

	buttons[button] = TIMEOUT;

func _process(delta):
	for i in range(8):
		if buttons[i] > 0:
			var node = get_node("TextureButton{button}".format({
							"button": i
						}))
			var cover = node.get_node("Cover")

			buttons[i] -= delta;

			if buttons[i] <= 0:
				cover.rect_size = Vector2(0, 64);
				node.disabled = false;
			else:
				var new_width = 64 / (TIMEOUT / buttons[i]);
				cover.rect_size = Vector2(new_width, 64);
