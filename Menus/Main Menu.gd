extends Control

onready var main = $Main
onready var settings = $Settings

signal start
signal stop

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if visible == true:
			visible = false
			settings.visible = false
			get_tree().paused = false
		else:
			visible = true
			settings.visible = false
			get_tree().paused = true


func _on_PlayButton_pressed():
	visible = false
	get_tree().paused = false
	emit_signal("start")


func _on_SettingsButton_pressed():
	main.visible = false
	settings.visible = true


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_BackButton_pressed():
	main.visible = true
	settings.visible = false


func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)


func _on_Barrel_dead():
	visible = true
	get_tree().paused = true
	emit_signal("stop")
