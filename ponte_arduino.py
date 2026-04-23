import serial
import socket
import time

arduino = serial.Serial('COM3', 9600)

print("Aguardando o Arduino iniciar...")
time.sleep(2)
arduino.reset_input_buffer()

# Configura o UDP para MANDAR pro Godot (Porta 4242)
rede = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Configura o UDP para OUVIR o Godot (Porta 4243)
rede.bind(("127.0.0.1", 4243))
rede.setblocking(0) # Isso faz o Python não travar esperando mensagem

print("🚀 Ponte Bidirecional Ligada! Godot <-> Arduino")

while True:
    try:
        # 1. Lê o Joystick e manda pro Godot
        if arduino.in_waiting > 0:
            dados = arduino.readline()
            rede.sendto(dados, ("127.0.0.1", 4242))
        
        # 2. Ouve o Godot e avisa o Arduino
        try:
            msg, _ = rede.recvfrom(1024)
            if msg == b"M": # Se o Godot mandou "M"
                arduino.write(b"M") # Repassa o "M" pro Arduino
        except BlockingIOError:
            pass # Fica quieto se o Godot não falou nada

    except ConnectionResetError:
        # Ignora a fofoca do Windows dizendo que o Godot tá fechado
        pass

    except Exception as e:
        print("Erro:", e)