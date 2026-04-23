const int pinoVRx = A0; 
const int pinoVRy = A1; 
const int pinoLED = 8;
const int pinoBuzzer = 9;

void setup() {
  Serial.begin(9600);
  pinMode(pinoLED, OUTPUT);
  pinMode(pinoBuzzer, OUTPUT);
}

void loop() {
  // 1. MANDA A DIREÇÃO PRO GODOT
  int valorX = analogRead(pinoVRx);
  int valorY = analogRead(pinoVRy);
  Serial.print(valorX);
  Serial.print(",");
  Serial.println(valorY);

  // 2. ESCUTA SE O GODOT MANDOU AVISO DE GAME OVER
  if (Serial.available() > 0) {
    char comando = Serial.read();
    
    if (comando == 'M') { // Se chegou o 'M' de "Morreu"
      digitalWrite(pinoLED, HIGH); // Acende o LED
      tone(pinoBuzzer, 2000, 5000);  // Toca um bipe grave e triste por 5 segundos
      delay(5000);                  // Espera o bipe acabar
      digitalWrite(pinoLED, LOW);  // Apaga o LED
    }
  }
  
  delay(20);
}