extends CharacterBody2D

@onready var tilemapper = %TileMapLayer
signal claim_tile_sig(x,y)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var top_left_corner := Vector2(0,0)
var bottom_right_corner := Vector2(0,0)
var edge_half_size = Vector2(30,30)

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
	top_left_corner = position - edge_half_size
	bottom_right_corner = position + edge_half_size
	
	var cell_tl = tilemapper.local_to_map(tilemapper.to_local(top_left_corner))
	var cell_br = tilemapper.local_to_map(tilemapper.to_local(bottom_right_corner))
	for x in range(cell_tl.x + 1, cell_br.x):
		for y in range(cell_tl.y + 1, cell_br.y):
			tilemapper.claim_tile(int(x),int(y))
	pass
