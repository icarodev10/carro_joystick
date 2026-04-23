extends RigidBody3D

func _on_body_entered(body):
	# Se no que ele bateu foi o seu carro...
	if body is VehicleBody3D:
		print("GAME OVER! O caixote te esmagou.")
		get_parent().ativar_game_over()
