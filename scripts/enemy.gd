extends CharacterBody2D
@onready var player = %player_cursor

var max_speed = 100
var acceleration = 1000


func get_direction_to_player() -> Vector2:
	return (player.global_position - global_position).normalized()


func accelerate_in_direction(direction: Vector2):
	var desired_velocity = direction * max_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func accelerate_to_player():
	var direction = get_direction_to_player()
	accelerate_in_direction(direction)


func _process(delta: float) -> void:
	accelerate_to_player()
	move_and_slide()
