extends Node2D
@onready var layerA := $TileMapLayerA
@onready var layerB := $TileMapLayerB

@onready var active_layer := layerA

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	layerB.visible = false
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
	if activeLayer.boundCheck(x,y) && !activeLayer.tileClaimed(x,y):
		hiddenLayer.claim_tile(x,y)
		floodFill(x+1,y)
		floodFill(x-1,y)
		floodFill(x,y+1)
		floodFill(x,y-1)
	
func ClaimTile(x,y):
	active_layer.claim_tile(x,y)

func GetTileFromGlobalPos(pos: Vector2) -> Vector2:
	return active_layer.local_to_map(active_layer.to_local(pos))
