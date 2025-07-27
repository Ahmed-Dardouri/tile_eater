extends CharacterBody2D

@onready var tilemapper = %TileMapper
@onready var enemy = %Enemy
signal claim_tile_sig(x, y)

const SPEED = 300.0

var previous_tile := Vector2.ZERO
var is_previous_tile_claimed := true
var is_player_safe = false


func _ready() -> void:
	$EnemyCollisionDetector.body_entered.connect(_on_body_entered)
	previous_tile = tilemapper.GetTileFromGlobalPos(position)
	is_player_safe = IsPlayerSafe()


func _process(delta: float) -> void:
	setTiles()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED

	move_and_slide()


func setTiles():
	var cur_tile_coords = tilemapper.GetTileFromGlobalPos(position)
	var is_cur_tile_claimed = tilemapper.TileClaimed(cur_tile_coords.x, cur_tile_coords.y)

	if !is_cur_tile_claimed:
		tilemapper.ClaimTile(cur_tile_coords.x, cur_tile_coords.y)

	if is_cur_tile_claimed && !is_previous_tile_claimed && cur_tile_coords != previous_tile:
		var tile_coords = tilemapper.GetTileFromGlobalPos(enemy.position)
		tilemapper.CutRegion(tile_coords.x, tile_coords.y)

	if cur_tile_coords != previous_tile:
		previous_tile = cur_tile_coords
		is_previous_tile_claimed = is_cur_tile_claimed
		is_player_safe = IsPlayerSafe()


func IsPlayerSafe() -> bool:
	var pos = position
	var points = []

	points.append(pos + Vector2(30, 30))
	points.append(pos + Vector2(30, -30))
	points.append(pos + Vector2(-30, 30))
	points.append(pos + Vector2(-30, -30))

	for point in points:
		var tile_pos = tilemapper.GetTileFromGlobalPos(point)
		if !tilemapper.TileClaimed(tile_pos.x, tile_pos.y):
			return false

	return true


func _on_body_entered(body):
	if body == enemy:
		print("The SCARY MONSTER got you!!")
