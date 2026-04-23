extends Area3D

func _on_body_entered(body):
	# Verifica se quem esbarrou no item foi o seu carro (VehicleBody3D)
	if body is VehicleBody3D:
		print("Pegou o item!")
		get_parent().somar_pontos()
		queue_free() # Esse comando destrói o item da tela
