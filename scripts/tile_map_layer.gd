extends TileMapLayer

@onready var tilemap = $"."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# for x in range(10,200):
	# 	for y in range(10,20):
	# 		claim_tile(x,y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
	
func claim_tile(x,y):
	tilemap.set_cell(Vector2i(x,y),0, Vector2i(2,2),0)
	pass
