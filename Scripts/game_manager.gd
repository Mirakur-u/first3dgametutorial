extends Node

class_name GameManager

@onready var finish_line: FinishLine = $"../FinishLine"
var player: Player
@onready var ui: UI = $"../UI"


func _ready() -> void:
	finish_line.level_won.connect(on_level_won)
	player = get_tree().get_first_node_in_group("player")



func on_level_won():
	player.linear_velocity = Vector3.ZERO
	player.freeze = true
	ui.on_level_finished()
	LevelManager.unlock_level(2)
