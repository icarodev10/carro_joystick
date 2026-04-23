extends Node3D

#  Carrega a "receita" da moeda
var cena_moeda = preload("res://Area3D.tscn")

var cena_caixote = preload("res://Caixote.tscn") 

@onready var tela_morte = $CanvasLayer/ColorRect

var pontos = 0
@onready var texto_placar = $CanvasLayer/Label # Puxa o texto

# Cria o "telefone" pra ligar pro Python
var udp_enviar := PacketPeerUDP.new()

func _ready():
	# Configura a porta que o Python está escutando
	udp_enviar.set_dest_address("127.0.0.1", 4243)

func _on_timer_timeout():
	# Cria uma cópia fresca da moeda
	var nova_moeda = cena_moeda.instantiate()
	
	#  Sorteia as coordenadas X e Z. 
	# Dica: Mude esse "-15.0, 15.0" para o tamanho real do seu chão de asfalto!
	var pos_x = randf_range(-15.0, 15.0)
	var pos_z = randf_range(-15.0, 15.0)
	
	#  Posiciona a moeda no espaço 3D. 
	# O Y está como 0.2 para garantir que ela fique em cima do chão.
	nova_moeda.position = Vector3(pos_x, 0.2, pos_z)
	
	#  Joga a moeda sorteada dentro do mapa
	add_child(nova_moeda)
	
func somar_pontos():
	pontos += 10
	texto_placar.text = "Pontos: " + str(pontos)
	
func _on_timer_caixote_timeout():
	var novo_caixote = cena_caixote.instantiate()
	
	var pos_x = randf_range(-30.0, 30.0)
	var pos_z = randf_range(-30.0, 30.0)
	
	# O segredo está no Y! Colocamos 15.0 para ele nascer lá no céu e cair com a gravidade.
	novo_caixote.position = Vector3(pos_x, 15.0, pos_z)
	
	add_child(novo_caixote)
	
func ativar_game_over():
	tela_morte.show() # Mostra a tela preta
	get_tree().paused = true # Congela a física, o carro e os spawners# Manda a letra "M" pela rede avisando que o carro foi esmagado
	udp_enviar.put_packet("M".to_ascii_buffer())


func _on_button_pressed():
	get_tree().paused = false # Despausa o motor da engine
	get_tree().reload_current_scene() # Recarrega tudo do zero
