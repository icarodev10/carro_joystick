# 🏎️ Godot Hardware Integration: Car Simulation (IoT)

Este projeto é uma simulação de direção desenvolvida na Godot Engine 4 que utiliza hardware externo (Arduino) como controlador principal. O foco aqui foi criar uma ponte de comunicação de baixa latência entre o mundo físico e o motor de jogo, aplicando conceitos de sistemas embarcados e redes.

## 🕹️ O Projeto
Diferente de um jogo convencional controlado por teclado, este simulador utiliza um **Joystick Analógico** real para o controle do veículo e fornece feedback físico ao jogador através de componentes eletrônicos. É um exemplo prático de como integrar software de alto nível com eletrônica de baixo nível.

## 📸 DEMO:


https://github.com/user-attachments/assets/d4445f47-07a0-42d8-a12e-f743d295a3d0


## 💻 Desafios Técnicos e Aprendizados
Como desenvolvedor focado em Backend e Automação, utilizei este projeto para explorar a comunicação entre três tecnologias distintas:

* **Arquitetura de Ponte (Python Bridge):** Implementação de um script em Python que atua como *middleman*. Ele lê os dados da porta Serial (Arduino) e os transmite via protocolo **UDP** para o Godot, superando limitações de acesso direto a portas seriais.
* **Protocolo de Baixa Latência:** Uso de Sockets UDP para garantir que a movimentação do carro responda instantaneamente aos comandos físicos (baixa latência de entrada).
* **Feedback de Hardware (Via de mão dupla):** O sistema não apenas recebe dados, mas também envia comandos de volta. No evento de colisão (Game Over), o Godot sinaliza o Python, que comanda o Arduino para acionar:
    * **LED de Alerta:** Feedback visual imediato.
    * **Buzzer Agudo:** Sinal sonoro de alta frequência (ajustado via código para 2000Hz) para indicar o erro.
* **Tratamento de Dados:** Conversão de valores analógicos brutos (0-1023) para vetores de movimento e rotação dentro do espaço 2D da Godot, utilizando funções de normalização.

## 🛠️ Tecnologias
* **Game Engine:** Godot 4.x (GDScript)
* **Linguagem de Integração:** Python 3 (PySerial & Sockets)
* **Microcontrolador:** Arduino (C++)

## 🔌 Hardware Utilizado
* Arduino Uno / Nano
* Módulo Joystick Analógico (Eixos X e Y)
* LED de Status (Feedback de colisão)
* Buzzer Ativo (Alerta sonoro)
* Protoboard e Jumpers Macho-Macho



## 🎮 Como Executar
1.  **Arduino:** Carregue o código `.ino` disponível na pasta `/joystick_carro` para sua placa.
2.  **Ponte Python:** Certifique-se de ter o `pyserial` instalado e execute `python ponte_arduino.py`.
3.  **Godot:** Abra o projeto no Godot Engine 4 e execute a cena principal (F5).

---
*Projeto desenvolvido como parte dos estudos de integração Hardware-Software.*
