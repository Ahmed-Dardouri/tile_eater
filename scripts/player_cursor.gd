extends CharacterBody2D

@onready var tilemapper = %TileMapper
signal claim_tile_sig(x,y)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var top_left_corner := Vector2(0,0)
var bottom_right_corner := Vector2(0,0)
var edge_half_size = Vector2(10,10)

func _physics_process(delta: float) -> void:
	
	setTiles()
	
	# print("top left : " + str(top_left_corner))
	# print("bottom right : " + str(bottom_right_corner))
	# print("position : " + str(position))
	# print("-------------------------")
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction*SPEED

	move_and_slide()
	
func setTiles():
	var tile_coords = tilemapper.GetTileFromGlobalPos(position)
	tilemapper.ClaimTile(tile_coords.x,tile_coords.y)
