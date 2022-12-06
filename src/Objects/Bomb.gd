extends KinematicBody2D

# physics variables
export var gravity: = Vector2(0, 4000)
export var speed: = Vector2(300, 1200)
export var velocity = Vector2.ZERO

# gameplay variables
var in_area = []
var playerName = ""
var explosionAnimationStarted = false

func _ready():
	self.hide()
	
func _physics_process(delta):
	velocity.x = 0
	if self.is_on_floor():
		velocity.y = 0
		
		#if player presses down while standing on a platform, go through platform
		
	# calculate velocity and move player according to that vector
	# bottom of screen is floor
	calculate_velocity()
	move_and_slide(velocity, Vector2.UP)
	
func calculate_velocity():
	velocity += gravity * get_physics_process_delta_time()

func explode(explode_who):
	$AnimatedSprite.play("bomb_explosion")
	explosionAnimationStarted = true
	
	for p in in_area:
		if p.visible and p.get_name() == explode_who and p in in_area:
			p.health -= 10
			
			if explode_who == "Player":
				var bar = get_node("../../PlayerHUD/Player1HealthBar/HealthMeter")
				bar.value -= 10
			elif explode_who == "Player2":
				var bar = get_node("../../PlayerHUD/Player2HealthBar/HealthMeter")
				bar.value -= 10
			
			p.check_win()
	
func explosionDone():
	if explosionAnimationStarted:
		self.visible = false
		explosionAnimationStarted = false
		$AnimatedSprite.play("bomb_lit")

func _on_bomb_area_enter(body):
	if not body in in_area:
		in_area.append(body)
	print("in area")

func _on_bomb_area_exit(body):
	if not body in in_area:
		in_area.erase(body)
	print("out area")
	
