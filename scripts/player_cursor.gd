extends CharacterBody2D

@onready var tilemapper = %TileMapper
signal claim_tile_sig(x, y)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var top_left_corner := Vector2(0, 0)
var bottom_right_corner := Vector2(0, 0)
var edge_half_size = Vector2(10, 10)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			var mouse_pos_global = get_global_mouse_position()
			var tile_coords = tilemapper.GetTileFromGlobalPos(mouse_pos_global)
			tilemapper.CutRegion(tile_coords.x, tile_coords.y)
	if Input.is_action_pressed("switch"):
		tilemapper.switchLayer()


func _process(delta: float) -> void:
	setTiles()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED

	move_and_slide()


func setTiles():
	var tile_coords = tilemapper.GetTileFromGlobalPos(position)

	tilemapper.ClaimTile(tile_coords.x, tile_coords.y)
