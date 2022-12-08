extends Node

var rng = RandomNumberGenerator.new()

var state = game_state.ended
enum game_state {running,ended}

export var spawn_time = 1.5

onready var timer = $Timer
onready var enemy = preload("res://Enemy/Enemy.tscn")

signal restart

func _on_Timer_timeout():
	var e = enemy.instance()
	var a = rng.randi_range(0,360)
	e.translation = Vector3(cos(a),0,sin(a))*20
	add_child(e)
	if timer.wait_time > 0:
		spawn_time -= 0.01
		timer.wait_time = spawn_time


func _on_Main_Menu_start():
	if state == game_state.ended:
		get_tree().paused = false
		state = game_state.running
		spawn_time = 1.5
		for e in get_tree().get_nodes_in_group("Enemy"):
			e.queue_free()
		var b = get_tree().get_nodes_in_group("Barrel")
		emit_signal("restart")
		timer.start(spawn_time)


func _on_Main_Menu_stop():
	state = game_state.ended
	timer.stop()
	get_tree().paused = true
