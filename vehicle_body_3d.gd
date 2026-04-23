extends VehicleBody3D

# Cria o receptor de rede
var udp := PacketPeerUDP.new()

func _ready():
	# Abre as portas para ouvir o Python
	udp.bind(4242)
	print("📡 Godot escutando a ponte Python na porta 4242...")

func _physics_process(delta):
	var aceleracao = 0.0
	var virar = 0.0
	
# 1. TENTA LER OS PACOTES QUE O PYTHON ESTÁ MANDANDO
	var pacote_recente = ""
	
	# O 'while' puxa TODOS os pacotes acumulados e guarda só o último!
	while udp.get_available_packet_count() > 0:
		pacote_recente = udp.get_packet().get_string_from_utf8().strip_edges()
		
	# Só processa se realmente chegou alguma coisa
	if pacote_recente.length() > 0:
		var valores = pacote_recente.split(",")
		if valores.size() == 2:
			var eixo_x = valores[0].to_float()
			var eixo_y = valores[1].to_float()
			
			
			virar = -(eixo_x - 512.0) / 512.0
			aceleracao = -(eixo_y - 512.0) / 512.0

	# 2. PLANO B: TECLADO (Se o Python estiver desligado)
	if virar == 0.0 and aceleracao == 0.0:
		aceleracao = Input.get_axis("ui_down", "ui_up")
		virar = Input.get_axis("ui_right", "ui_left")
		
	# 3. APLICA A FORÇA NO CARRO
	steering = virar * 0.4
	engine_force = aceleracao * 1000.0
