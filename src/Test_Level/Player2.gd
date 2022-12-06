extends Player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calculate_velocity():
	if Input.is_action_pressed("move_left_p2"):
		velocity.x = -speed.x
		$AnimatedSprite.set_flip_h(true)
	if Input.is_action_pressed("move_right_p2"):
		velocity.x = speed.x
		$AnimatedSprite.set_flip_h(false)
	if Input.is_action_pressed("jump_p2"):
		if self.is_on_floor():
			velocity.y = -speed.y
			get_node("../JumpSound").play()
	
	velocity += gravity * get_physics_process_delta_time()
	
func check_for_bomb():
	if not bombSet and Input.is_action_just_pressed("bomb_p2"):
		bombSet = true
		
		#var bomb = preload("res://src/Objects/bomb.tscn").instance()
		#bomb.set_name("PlayerBomb") # Ensure unique name for the bomb
		var bomb = get_node("../Bombs/Player2Bomb")
		bomb.show()
		
		var playerNode = get_node("../Player2")
		bomb.position = playerNode.position - Vector2(0,10)
		bomb.playerName = "Player2"
		
		#get_node("../Bombs").add_child(bomb)
		
	
	if bombSet and Input.is_action_just_pressed("detonate_p2"):
		bombSet = false
		get_node("../ExplosionSound").play()
		
		var bomb = get_node("../Bombs/Player2Bomb")
		bomb.explode("Player")
		
func reset_state():
	health = 100
	position = Vector2(1760, 344)
