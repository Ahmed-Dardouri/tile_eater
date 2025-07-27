extends TileMapLayer

const CLAIMED_ATLAS_COORDS = Vector2i(2,2)
const UNCLAIMED_ATLAS_COORDS = Vector2i(4,3)

const Y_EDGE = 19
const X_EDGE = 35

const top_left_corner = Vector2(-X_EDGE,-Y_EDGE)
const bot_right_corner = Vector2(X_EDGE,Y_EDGE)

const BORDER_RADIUS = 2

@onready var tilemap = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(top_left_corner.x - BORDER_RADIUS, bot_right_corner.x + BORDER_RADIUS):
		for y in range(top_left_corner.y - BORDER_RADIUS, bot_right_corner.y + BORDER_RADIUS):
			claim_tile(x,y)
	
	for x in range(top_left_corner.x , bot_right_corner.x):
		for y in range(top_left_corner.y , bot_right_corner.y):
			unclaim_tile(x,y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
	
func claim_tile(x,y):
	tilemap.set_cell(Vector2i(x,y),0, CLAIMED_ATLAS_COORDS,0)
	pass
	
func unclaim_tile(x,y):
	tilemap.set_cell(Vector2i(x,y),0, UNCLAIMED_ATLAS_COORDS,0)
	pass

func tileClaimed(x,y) -> bool:
	return tilemap.get_cell_atlas_coords() == CLAIMED_ATLAS_COORDS

func FillAllAsClaimed():
	for x in range(top_left_corner.x, bot_right_corner.x):
		for y in range(top_left_corner.y, bot_right_corner.y):
			claim_tile(x,y)

func boundCheck(x,y) -> bool:
	var check := true
	if x > bot_right_corner.x || x < top_left_corner.x || y > bot_right_corner.y || y < top_left_corner.y:
		check = false
	return check
