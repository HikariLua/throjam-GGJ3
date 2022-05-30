class_name PlayerStats
extends Node

signal leveled_up(previous_level)

var level: int = 1
var attackRecoverTimer: Timer = null

var can_attack: bool = true
var experience: int = 0 
var experience_required: int = get_experience_required()


func get_experience_required() -> int:
	return int(round(pow(level + 1, 1.5) * 2 + 10))


func _ready():
	attackRecoverTimer = Timer.new()
	call_deferred("add_child", attackRecoverTimer)

	var err = attackRecoverTimer.connect("timeout", self, "on_AttackRecoverTimer_timeout")
	assert(err == OK)


func gain_experience(experience_value: int):
	experience += experience_value

	while experience >= experience_required:
		experience -= experience_required
		level_up()


func level_up():
	level += 1
	emit_signal("leveled_up", level - 1)

	experience_required = get_experience_required()


func on_AttackRecoverTimer_timeout():
	can_attack = true
