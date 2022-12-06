extends TextureButton

func playAgain():
	print("play again")
	get_tree().paused = false
	get_parent().get_parent().visible = false
	
	get_node("../../../Player1HealthBar/HealthMeter").value = 100
	get_node("../../../Player2HealthBar/HealthMeter").value = 100
	
	get_node("../../../../Player").reset_state()
	get_node("../../../../Player2").reset_state()
