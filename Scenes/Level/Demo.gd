extends Spatial

onready var locations = [$PatrolLoc/Loc1, $PatrolLoc/Loc2, $PatrolLoc/Loc3, $PatrolLoc/Loc4,
						$PatrolLoc/Loc5, $PatrolLoc/Loc6, $PatrolLoc/Loc7, $PatrolLoc/Loc8, $PatrolLoc/Loc9,
						$PatrolLoc/Loc10, $PatrolLoc/Loc11, $PatrolLoc/Loc12]

onready var enemy = $Navigation/Enemy
onready var player = $Player
onready var nav = $Navigation

var prev_loc = null
var current_loc = null

func _ready():
	enemy.set_nav(nav)
	enemy.set_target(player)
	current_loc = locations[rand_range(0,locations.size())]
	MusicController.music = $Ambient
	MusicController.tween = $MusicTween
	MusicController.default_db = -20
	MusicController.fade_in()

func _process(delta):
	if enemy.current_state == enemy.STATE.PATROL:
		enemy.set_target(current_loc)
	elif enemy.current_state == enemy.STATE.CHASE:
		enemy.set_target(player)

func _on_Enemy_destination_reached():
	current_loc = locations[rand_range(0,locations.size())]
	if prev_loc != null:
		while current_loc == prev_loc:
			current_loc = locations[rand_range(0,locations.size())]
	enemy.set_target(current_loc)
