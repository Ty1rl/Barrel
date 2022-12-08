extends Spatial

export var health = 10
export var fire_rate = 0.5
export var projectile_amount = 1
export var fire_range = 5

var xp = 0
var next_level = 10

onready var top = $Top
onready var offset = $Top/Offset
onready var timer = $Timer
onready var sound = $AudioStreamPlayer
onready var particals = $Top/Offset/CPUParticles
onready var area_range = $Area/CollisionShape
onready var bullet = preload("res://Barrel/Bullet/Bullet.tscn")

onready var rng = RandomNumberGenerator.new()

signal damaged(damage)
signal dead
signal ex_up(e)
signal level_up(l)

var targets:Array

func _physics_process(delta):
	if !targets.empty():
		top.look_at(targets[0].translation,Vector3.UP)
		shoot()
		
func shoot():
	if timer.is_stopped():
		for p in projectile_amount:
			var b = bullet.instance()
			b.transform = offset.transform
			b.rotation = Vector3(rng.randf_range(-0.1,0.1),rng.randf_range(-0.1,0.1),rng.randf_range(-0.1,0.1))
			b.apply_central_impulse((targets[0].translation - b.translation).normalized()*20)
			get_parent().add_child(b)
		sound.set_pitch_scale(rng.randf_range(0.5,1.5))
		sound.play()
		particals.emitting = true
		timer.start(fire_rate)

func enemy_ded():
	xp += 1
	emit_signal("ex_up",xp)
	if xp >= next_level:
		next_level *= 2
		emit_signal("level_up",next_level)

func apply_damage(target,d):
	health -= d
	emit_signal("damaged",d)
	if health <= 0:
		emit_signal("dead")
	targets.erase(target)

func _on_Area_body_entered(body):
	targets.append(body)

func _on_Area_body_exited(body):
	targets.erase(body)


func _on_HUD_up_fire_rate():
	fire_rate -= 0.1


func _on_HUD_up_projectile_amount():
	projectile_amount += 1


func _on_HUD_up_range():
	fire_range += 1
	area_range.get_shape().set_radius(fire_range)


func _on_Main_Menu_start():
	health = 10
	fire_rate = 0.5
	projectile_amount = 1
	fire_range = 5
	area_range.get_shape().set_radius(fire_range)
	xp = 0
	emit_signal("ex_up",xp)
	next_level = 10
	emit_signal("level_up",next_level)


func _on_Word_restart():
	health = 10
	fire_rate = 0.5
	projectile_amount = 1
	fire_range = 5
	xp = 0
	next_level = 10
