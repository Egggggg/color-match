extends Node

export (PackedScene) var blob;
export (Array, StreamTexture) var blobs = [null];

func _ready():
	randomize();
	_spawn();

func _spawn():
	if GameManager.full:
		return;

	var spot = _find_spot();
	var blob_instance = blob.instance();
	var sprite = GameManager.arr_choose(blobs);

	if spot.side in [0, 2]:
		GameManager.board[spot.cell][spot.pos] = blob_instance;
	else:
		GameManager.board[spot.pos][spot.cell] = blob_instance;

	GameManager.check_full();

	get_node("..").call_deferred("add_child", blob_instance);

	blob_instance.position = spot.vector;
	blob_instance.texture = sprite;

func _find_spot():
	var found = false;
	var side = null;
	var pos = null;
	var cell = null;

	while !found:
		side = GameManager.choose(0, 4);
		pos = GameManager.choose(0, 14);
		cell = _find_cell(side, pos);
		found = cell != -1;

	if side == 0: # top
		GameManager.board[cell][pos] = 1;
		var vector = Vector2((pos * 32) + 64, (cell * 32) + 64);

		return {
			"vector": vector,
			"side": side,
			"pos": pos,
			"cell": cell
		}
	elif side == 1: #right
		GameManager.board[pos][cell] = 1;
		var vector = Vector2((cell * 32) + 64, (pos * 32) + 64);

		return {
			"vector": vector,
			"side": side,
			"pos": pos,
			"cell": cell
		}
	elif side == 2: # bottom
		GameManager.board[cell][pos] = 1; 
		var vector = Vector2((pos * 32) + 64, (cell * 32) + 64);

		return {
			"vector": vector,
			"side": side,
			"pos": pos,
			"cell": cell
		}
	elif side == 3: # left
		GameManager.board[pos][cell] = 1;
		var vector = Vector2((cell * 32) + 64, (pos * 32) + 64);

		return {
			"vector": vector,
			"side": side,
			"pos": pos,
			"cell": cell
		}

func _find_cell(side, pos):
	if side == 0:
		for i in range(14):
			if GameManager.board[i][pos] == null:
				return i;
	elif side == 1:
		for i in range(13, -1, -1): # reverse from 13 to 0
			if GameManager.board[pos][i] == null:
				return i;
	elif side == 2:
		for i in range(13, -1, -1):
			if GameManager.board[i][pos] == null:
				return i;
	elif side == 3:
		for i in range(14):
			if GameManager.board[pos][i] == null:
				return i;

	return -1;
