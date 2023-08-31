extends KinematicBody2D
class_name Player

# physics variables 
export var gravity: = Vector2(0, 4000)
export var speed: = Vector2(300, 1200)
export var velocity = Vector2.ZERO


# gameplay variables
var bombSet = false
var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x = 0
	if self.is_on_floor():
		velocity.y = 0
		
		#if player presses down while standing on a platform, go through platform
		
	# calculate velocity and move player according to that vector
	# bottom of screen is floor
	calculate_velocity()
	check_for_bomb()
	move_and_slide(velocity, Vector2.UP)
	
func calculate_velocity():
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed.x
		$AnimatedSprite.set_flip_h(true)
	if Input.is_action_pressed("move_right"):
		velocity.x = speed.x
		$AnimatedSprite.set_flip_h(false)
	if Input.is_action_pressed("jump"):
		if self.is_on_floor():
			velocity.y = -speed.y
			get_node("../JumpSound").play()
	
	velocity += gravity * get_physics_process_delta_time()
	
func check_for_bomb():
	var bomb = get_node("../Bombs/PlayerBomb")
	if not bombSet and Input.is_action_just_pressed("bomb") and bomb.explosionAnimationStarted == false:
		bombSet = true
		
		#var bomb = preload("res://src/Objects/bomb.tscn").instance()
		#bomb.set_name("PlayerBomb") # Ensure unique name for the bomb
		#var bomb = get_node("../Bombs/PlayerBomb")
		bomb.show()
		
		var playerNode = get_node("../Player")
		bomb.position = playerNode.position - Vector2(0,10)
		bomb.playerName = "Player"
		
		#get_node("../Bombs").add_child(bomb)
		
	
	if bombSet and Input.is_action_just_pressed("detonate"):
		bombSet = false
		get_node("../ExplosionSound").play()
		
		#var bomb = get_node("../Bombs/PlayerBomb")
		bomb.explode("Player2")
		
func check_win():
	if health <= 0:
		print(str(self.get_name()) + " loses")
		var winner = ""
		if (self.get_name() == "Player"):
			winner = "Player 2"
		else:
			winner = "Player 1"
		
		get_node("../PlayerHUD/GameOver/WinnerText").set_text(str(winner) + " Wins")
		get_node("../PlayerHUD/GameOver").visible = true
		get_tree().paused = true

func reset_state():
	health = 100
	position = Vector2(164, 351)
	
	
