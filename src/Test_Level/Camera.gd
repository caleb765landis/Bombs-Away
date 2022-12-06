extends Camera2D

export (NodePath) var Player
export (NodePath) var Player2

func _ready():
	Player = get_node(Player)
	Player2 = get_node(Player2)
	set_physics_process(true)

func _physics_process(delta):
	var position = (Player.global_position + Player2.global_position) * 0.5

	# width 1920 height 1080
	var zoom_factor1 = abs(Player.global_position.x-Player2.global_position.x)/(OS.get_window_size().x-100)
	var zoom_factor2 = abs(Player.global_position.y-Player2.global_position.y)/(OS.get_window_size().y-100)
	var zoom_factor = max(max(zoom_factor1, zoom_factor2), 0.5)

	#self.zoom = Vector2(zoom_factor, zoom_factor)
	
	set_global_position(position)
	set_zoom(Vector2(zoom_factor, zoom_factor) / 2)

