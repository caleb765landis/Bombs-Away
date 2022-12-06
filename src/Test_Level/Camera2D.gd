extends Camera2D

export (NodePath) var Player
export (NodePath) var Player2
export var player_dist_from_edge = 300
export var min_zoom = 0.9

func _ready():
	Player = get_node(Player)
	Player2 = get_node(Player2)
	set_physics_process(true)

func _physics_process(delta):
	var p1_pos = Player.position
	var p2_pos = Player2.position
	
	var camera_pos = (p1_pos + p2_pos) * 0.5
	#var zoom_factor = (p1_pos.distance_to(p2_pos) * 2) * zoom_scalar
	
	var zoom_factor_x = abs(p1_pos.x - p2_pos.x) / (OS.window_size.x - player_dist_from_edge)
	var zoom_factor_y = abs(p1_pos.y - p2_pos.y) / (OS.window_size.y - player_dist_from_edge)
	var zoom_factor = max(max(zoom_factor_x, zoom_factor_y), min_zoom)
	
	
	set_global_position(camera_pos)
	# / 2
	set_zoom(Vector2(zoom_factor, zoom_factor))
	

