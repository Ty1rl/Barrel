extends Control

onready var timer = $Timer
onready var xp_bar = $ProgressBar
onready var xp_label = $ProgressBar/Label
onready var Upgrades = $Upgrades
onready var health_bar = $CenterContainer/ProgressBar

signal up_range
signal up_fire_rate
signal up_projectile_amount

func _on_Barrel_damaged(damage):
	health_bar.value -= damage
	health_bar.visible = true
	timer.start()


func _on_Timer_timeout():
	health_bar.visible = false


func _on_Barrel_ex_up(e):
	xp_bar.value = e


func _on_Barrel_level_up(l):
	xp_bar.max_value = l
	get_tree().paused = true
	Upgrades.visible = true


func _on_Button_pressed():
	emit_signal("up_range")
	get_tree().paused = false
	Upgrades.visible = false


func _on_Button2_pressed():
	emit_signal("up_fire_rate")
	get_tree().paused = false
	Upgrades.visible = false


func _on_Button3_pressed():
	emit_signal("up_projectile_amount")
	get_tree().paused = false
	Upgrades.visible = false


func _on_ProgressBar_value_changed(value):
	xp_label.set_text(str(value))


func _on_Word_restart():
	health_bar.value = 10
	xp_bar.value = 0
	xp_bar.max_value = 10
	xp_label.set_text("")
