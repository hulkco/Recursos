/*
 Programa en Processing para controlar el encendido de un LED conectado a Arduino
 con un pulsador en el PC mediante comunicacion a traves del puerto serie
 En Arduino hay que cargar el programa: Ejemplos--> Communication --> Physical Pixel
 Enero 2018
 Jose Pujol
 */

// se importa la libreria serial
import processing.serial.*;
Serial myPort;    // se crea myPort de tipo Serial                   

// variables pulsador
int xpos, ypos;  //posición pulsador
int altura=75;
int longitud=100;
boolean overButton = false;
int colorButton=125;

// variables LED
boolean ledStatus=false;
int radio=75;
int colorRLED=100;

void setup() {
  size(500, 300);  // tamaño de la pantalla
  // establece la posicion del pulsador
  xpos = width/3;
  ypos = height/2;
  // imprime la lista de los puertos series 
  printArray(Serial.list());
  // selecciona el puerto 5 que en este caso es al que se conecta Arduino
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
}

void draw() {

  // dibujamos el fondo
  background(10);  
  // dibujamos el pulsador
  fill(colorButton);    // color de relleno del pulsador
  rectMode(CENTER);    // coordenadas en el centro del rectangulo
  rect(xpos, ypos, longitud, altura, 8);
  // dibujamos el LED
  fill(colorRLED, 0, 0);
  ellipse(width*2/3, height/2, radio, radio);

  // Si el raton está encima del pulsador
  if (mouseX > xpos-longitud/2 && mouseX < xpos+longitud/2 && 
    mouseY > ypos-altura/2 && mouseY < ypos+altura/2) {
    overButton = true;
    colorButton=200;
  } else {
    overButton = false;
    colorButton=150;
  }
}

// interrupcion en caso de presionarse el raton
void mousePressed() {
  // si el raton está sobre el pulsador
  if (overButton) { 
    // si el estado del led es true
    if (ledStatus) {
      ledStatus=false;  // cambiamos el estado a falso
      colorRLED= 100;  // apagamos el led de la animacion
      myPort.write('L');  // mandamos L por el puerto serie
    } else {
      ledStatus=true;    // cambiamos el estado a cierto
      colorRLED= 255;    // encendemos el led de la animacion
      myPort.write('H');  // mandamos H por el puerto serie
    }
  }
}
