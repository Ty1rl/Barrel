extends RigidBody

export var health = 10
export var speed = 10
export var damage = 1

onready var sound = $AudioStreamPlayer
onready var particals = $CPUParticles
onready var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	particals.emitting = true
	sound.set_pitch_scale(rng.randf_range(0.25,0.5))
	sound.play()

func _physics_process(delta):
	var direction = Vector3.ZERO - translation
	direction.normalized() * speed
	add_central_force(direction * speed * delta)

func apply_damage(d):
	health -= d
	if health <= 0:
		get_tree().call_group("Barrel","enemy_ded")
		queue_free()

func _on_Enemy_body_entered(body):
	if body.is_in_group("Tower"):
		body.get_parent().apply_damage(self,damage)
		queue_free()
