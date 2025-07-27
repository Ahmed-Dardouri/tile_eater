extends Node2D
@onready var layerA := $TileMapLayerA
@onready var layerB := $TileMapLayerB

@onready var active_layer := layerA

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	layerB.visible = false
	fillHiddenLayerAsSafe()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getActiveLayer() -> TileMapLayer:
	return active_layer
	
func getHiddenLayer() -> TileMapLayer:
	if(active_layer == layerA):
		return layerB
	else:
		return layerA

func switchLayer():
	if(active_layer == layerA):
		active_layer = layerB
		layerA.visible = false
		layerB.visible = true
	else:
		active_layer = layerA
		layerA.visible = true
		layerB.visible = false

func fillHiddenLayerAsSafe():
	var hiddenLayer := getHiddenLayer()
	hiddenLayer.FillAllAsClaimed()
	
func floodFill(x,y):
	var activeLayer := getActiveLayer()
	var hiddenLayer := getHiddenLayer()
	
	var stack = [Vector2i(x, y)]
	while stack.size() > 0:
		var pos = stack.pop_back()
		if !activeLayer.boundCheck(pos.x, pos.y) || activeLayer.tileClaimed(pos.x, pos.y) || !hiddenLayer.tileClaimed(pos.x, pos.y):
			continue
	
		hiddenLayer.unclaim_tile(pos.x, pos.y)
		stack.append(pos + Vector2i(1, 0))
		stack.append(pos + Vector2i(-1, 0))
		stack.append(pos + Vector2i(0, 1))
		stack.append(pos + Vector2i(0, -1))
		
	
func CutRegion(x,y):
	floodFill(x,y)
	switchLayer()
	fillHiddenLayerAsSafe()
	
func ClaimTile(x,y):
	active_layer.claim_tile(x,y)
	
func TileClaimed(x,y) -> bool:
	var hiddenLayer := getHiddenLayer()
	return hiddenLayer.tileClaimed(x,y)
	
func GetTileFromGlobalPos(pos: Vector2) -> Vector2:
	return active_layer.local_to_map(active_layer.to_local(pos))
