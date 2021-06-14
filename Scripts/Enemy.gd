extends KinematicBody

signal destination_reached
signal player_collide

const WALK_SPEED = 8
const CHASE_SPEED = 13
enum STATE {PATROL, CHASE}

var current_state = STATE.PATROL
var target = null
var nav: Navigation = null
var motion = Vector3()
var attack_allowed = true

onready var player = get_owner().get_node("Player")

var jumpscare_allowed = false

func _physics_process(delta):
	if target == null:
		return
	var path = get_path_to(target.global_transform.origin)
	if path.size() > 0:
		move_along_path(path, current_state, delta)
	
func get_path_to(_target):
	return nav.get_simple_path(global_transform.origin, _target)

func move_along_path(path, state, delta):
	if path.size() <= 0:
		return
	path.remove(0)
	var current_path = path[0]
	if global_transform.origin.distance_to(current_path) < 0.1:
		path.remove(0)
	if state == STATE.CHASE:
		motion = (current_path-translation).normalized() * CHASE_SPEED
	elif state == STATE.PATROL:
		if global_transform.origin.distance_to(target.global_transform.origin) < 3:
			emit_signal("destination_reached")
		motion = (current_path-translation).normalized() * WALK_SPEED
	motion = move_and_slide(motion)
	look_at(current_path, Vector3.UP)

func set_target(_target):
	self.target = _target

func set_nav(_nav):
	self.nav = _nav

func _on_PlayerDetect_body_entered(body):
	current_state = STATE.CHASE
	if jumpscare_allowed:
		$Jumpscare.play()
		jumpscare_allowed = false
	#MusicController.music = get_owner().get_node("Chase")
	#MusicController.play_music()


func _on_PlayerDetect_body_exited(body):
	current_state = STATE.PATROL
	#MusicController.stop_music()	

func _on_DamageArea_body_entered(body):
	if attack_allowed:
		emit_signal("player_collide")
		body.transform.origin - transform.origin
		$AttackTimer.start()
		attack_allowed = false

func _on_JumpScareTimer_timeout():
	jumpscare_allowed = true

### MAKE SURE TO CHANGE ATTACKTIMER BACK TO 3!
func _on_AttackTimer_timeout():
	attack_allowed = true
	if $DamageArea.overlaps_body(player):
		_on_DamageArea_body_entered(player)

