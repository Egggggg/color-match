extends Node

signal game_over;
signal points_changed(new_value);

const VALUE = 1;
const MULT_VALUE = .05;

var board = [];
var full = false;
var points = 0 setget _set_points;

func _ready():
	randomize();

	for y in range(14):
		board.append([]);

		for _x in range(14):
			board[y].append(null);

func _set_points(new_value):
	points = new_value;
	
	emit_signal("points_changed", new_value);

func arr_choose(array):
	return array[randi() % array.size()];

func choose(minimum, maximum):
	return (randi() % (maximum - minimum)) + minimum

func check_full():
	for y in range(14):
		if null in board[y]:
			full = false;
			return;

	full = true;
	emit_signal("game_over");

	for y in range(14):
		for x in range(14):
			if board[y][x] == null:
				continue

			board[y][x].queue_free();

func attack(h):
	var mult = 1;
	var total = 0;

	for y in range(14):
		for x in range(14):
			if board[y][x] == null:
				continue;

			var dif = abs(board[y][x].modulate.h - h);

			if dif <= .125:
				board[y][x].queue_free();
				board[y][x] = null;

				total += VALUE;
				mult += MULT_VALUE;

	_set_points(points + (total * mult));
