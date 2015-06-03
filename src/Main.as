package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	[SWF(width = "1200", height = "700", backgroundColor = "0x000000", frameRate = "30")]
	public class Main extends Sprite
	{
		public var vida:int = 3;
		public var vidaInterna:int = 3;
		public var etapa:int = 1;
		public var timerMenu:int =1;
		public var contenedorTitulo:Sprite;
		public var contenedorConfirmar:Sprite;
		public var mc_vidaCartel:Sprite = new Mc_Vida;
		public var vidaNumero:Sprite = new Sprite;
		public var mc_uno:Sprite = new Mc_Uno;
		public var mc_dos:Sprite = new Mc_Dos;
		public var mc_tres:Sprite = new Mc_Tres;
		public var camion11:Sprite = new Mc_Camion;
		public var camion12:Sprite = new Mc_Camion;
		public var camion13:Sprite = new Mc_Camion;
		public var camion21:Sprite = new Mc_Camion;
		public var camion22:Sprite = new Mc_Camion;
		public var camion23:Sprite = new Mc_Camion;
		public var camion31:Sprite = new Mc_Camion;
		public var camion32:Sprite = new Mc_Camion;
		public var sapito:Sprite = new Mc_Burgeranda;
		public var presentacion:Sprite;
		public var personaje:Sprite;
		public var enemigo11:Sprite;
		public var enemigo12:Sprite;
		public var enemigo13:Sprite;
		public var enemigo21:Sprite;
		public var enemigo22:Sprite;
		public var enemigo23:Sprite;
		public var enemigo31:Sprite;
		public var enemigo32:Sprite;
		public var bordeSuperior:Sprite;
		public var bordeInferior:Sprite;
		public var bordeDerecho:Sprite;
		public var bordeIzquierdo:Sprite;
		public var bordesGrosor:int = 50;
		public var personajeXInicial:int = stage.stageWidth/2;
		public var personajeYInicial:int = stage.stageHeight - 50;
		public var enemigosWidth:int = 120;
		public var enemigosHeight:int = 60;
		public var velocidadPersonaje:int = 5;
		public var velocidadPiso1:int = 10;
		public var velocidadPiso2:int = 15;
		public var velocidadPiso3:int = 25;
		public var irArriba:Boolean = false;
		public var irAbajo:Boolean = false;
		public var irDer:Boolean = false;
		public var irIzq:Boolean = false;
		public var enter:Boolean = false;
		public var etapa1Completa:Boolean = false;
		public var etapa2Completa:Boolean = false;
		public var etapa3Completa:Boolean = false;
		public var etapa4Completa:Boolean = false;
		public var piso1:int = 500;
		public var piso2:int = 300;
		public var piso3:int = 100;
		
		public function Main()
		{
			//Acomodar Sprites
			camion11.width = enemigosWidth;
			camion11.height = enemigosHeight;
			camion11.rotation = 180;
			camion12.width = enemigosWidth;
			camion12.height = enemigosHeight;
			camion12.rotation = 180;
			camion13.width = enemigosWidth;
			camion13.height = enemigosHeight;
			camion13.rotation = 180;
			camion21.width = enemigosWidth;
			camion21.height = enemigosHeight;
			camion22.width = enemigosWidth;
			camion22.height = enemigosHeight;
			camion23.width = enemigosWidth;
			camion23.height = enemigosHeight;
			camion31.width = enemigosWidth;
			camion31.height = enemigosHeight;
			camion31.rotation = 180;
			camion32.width = enemigosWidth;
			camion32.height = enemigosHeight;
			camion32.rotation = 180;
			
			sapito.width = 60;
			sapito.height = 60;
			
			mc_vidaCartel.width = 80;
			mc_vidaCartel.height = 20;
						
			vidaNumero.width = 20;
			vidaNumero.height = 20;
			
			mc_uno.width = 20;
			mc_uno.height = 20;
			
			mc_dos.width = 20;
			mc_dos.height = 20;
			
			mc_tres.width = 20;
			mc_tres.height = 20;
			
			
			
			//Escucadores de eventos
			stage.addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, presionoTecla);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, soltoTecla);
			
		}
		
		public function update (evento:Event):void
		{
			if (timerMenu < 125)
			{
				timerMenu++;
			}
			switch (etapa)
			{
				case 1:
					if (!enter && !etapa1Completa)
					{
						timerMenu = 0;
						dibujarEtapa1();	
					}
					else if (enter && timerMenu >= 125)
					{
						etapa = 2;
					}
					break;
				
				case 2:
					if (!etapa2Completa)
					{
						dibujarEtapa2();
					}
					else
					{
						moverPersonaje();
						moverEnemigos();
						comprobarColisiones();
						comprobarVida();
					}
					break;
				
				case 3:
					if (enter != true && !etapa3Completa)
					{
						timerMenu = 0;
						dibujarEtapa3();	
					}
					else if (enter && timerMenu >= 125)
					{
						etapa = 2;
					}
					break;
				
				case 4:
					if (enter != true && !etapa4Completa)
					{
						timerMenu = 0;
						dibujarEtapa4();	
					}
					else if (enter && timerMenu >= 125)
					{
						etapa = 2;
					}
					break;
			}
		}
		
		public function dibujarEtapa1():void
		{
			dibujarCartel(new Mc_Titulo,new Mc_Enter);
			
			etapa1Completa = true;
		}
		
		public function dibujarEtapa2():void
		{			
			etapa1Completa = false;
			etapa3Completa = false;
			etapa4Completa = false;
			
			stage.removeChild(contenedorTitulo);
			stage.removeChild(contenedorConfirmar);
			
			//Creacion de enemigos
			enemigo11 = dibujarRectangulo(0x00ffff, 0,enemigosWidth, enemigosHeight, - enemigosWidth / 2 , piso1);
			enemigo12 = dibujarRectangulo(0x00ffff, 0,enemigosWidth, enemigosHeight, stage.stageWidth / 2 + ( ( stage.stageWidth - enemigosWidth * 2 ) / 6 + enemigosWidth / 2) , piso1);
			enemigo13 = dibujarRectangulo(0x00ffff, 0,enemigosWidth, enemigosHeight, stage.stageWidth / 2 - ( ( stage.stageWidth - enemigosWidth * 2 ) / 6 + enemigosWidth / 2) , piso1);
			enemigo21 = dibujarRectangulo(0x00ffff, 0,enemigosWidth, enemigosHeight, stage.stageWidth / 2 + ( ( stage.stageWidth - enemigosWidth * 2 ) / 6 + enemigosWidth / 2) , piso2);
			enemigo22 = dibujarRectangulo(0x00ffff, 0,enemigosWidth, enemigosHeight, stage.stageWidth / 2 - ( ( stage.stageWidth - enemigosWidth * 2 ) / 6 + enemigosWidth / 2) , piso2);
			enemigo23 = dibujarRectangulo(0x00ffff, 0,enemigosWidth, enemigosHeight, stage.stageWidth + enemigosWidth / 2 , piso2);
			enemigo31 = dibujarRectangulo(0x00ffff, 0,enemigosWidth, enemigosHeight, - enemigosWidth / 2 , piso3);
			enemigo32 = dibujarRectangulo(0x00ffff, 0,enemigosWidth, enemigosHeight, stage.stageWidth / 2 , piso3);
			
			
			//Creacion de personaje
			personaje = dibujarRectangulo(0x0000ff, 0,60,60,personajeXInicial,personajeYInicial);
			
			//Creacion de bordes
			bordeSuperior = dibujarRectangulo(0x000000, 1,stage.stageWidth,bordesGrosor,stage.stageWidth/2,-bordesGrosor/2);
			bordeInferior = dibujarRectangulo(0x000000, 1,stage.stageWidth,bordesGrosor,stage.stageWidth/2,stage.stageHeight+bordesGrosor/2);
			bordeDerecho = dibujarRectangulo(0x000000, 1,bordesGrosor,stage.stageHeight,stage.stageWidth+bordesGrosor/2,stage.stageHeight/2);
			bordeIzquierdo = dibujarRectangulo(0x000000, 1,bordesGrosor,stage.stageHeight,-bordesGrosor/2,stage.stageHeight/2);
			
			//Pitado de sprites
			
			enemigo11.addChild(camion11);
			enemigo12.addChild(camion12);
			enemigo13.addChild(camion13);
			enemigo21.addChild(camion21);
			enemigo22.addChild(camion22);
			enemigo23.addChild(camion23);
			enemigo31.addChild(camion31);
			enemigo32.addChild(camion32);
			
			personaje.addChild(sapito);
			
			//vida					//ATENCION: A LOT OF HARDCODEO!!!!
			
			vidaNumero = mc_tres;
			
			stage.addChild(mc_vidaCartel);
			
			mc_vidaCartel.x = stage.stageWidth - 45;
			mc_vidaCartel.y = stage.stageHeight - 30;
			
			dibujarVida();
			
			vida = 3;
			vidaInterna = 3;
			
			etapa2Completa = true;
		}
		
		public function dibujarEtapa3():void
		{
			etapa1Completa = false;
			etapa2Completa = false;
			etapa4Completa = false;
			
			limpiarEtapa2();
			
			dibujarCartel(new Mc_Cabio,new Mc_Sufrir);
			
			etapa3Completa = true;
		}
		
		public function dibujarEtapa4():void
		{
			etapa1Completa = false;
			etapa2Completa = false;
			etapa3Completa = false;
			
			limpiarEtapa2();
			
			dibujarCartel(new Mc_Ganaste,new Mc_Reiniciar);
			
			etapa4Completa = true;
		}
		
		public function dibujarCartel(grande:Sprite, chico:Sprite):void
		{
			contenedorTitulo = grande;
			contenedorConfirmar = chico;
			
			stage.addChild(contenedorTitulo);
			stage.addChild(contenedorConfirmar);
			
			contenedorTitulo.x = stage.stageWidth/2;
			contenedorTitulo.y = stage.stageHeight/5;
			
			contenedorConfirmar.x = stage.stageWidth/2;
			contenedorConfirmar.y = stage.stageHeight/3 * 2;
			
		}
		
		public function limpiarEtapa2():void
		{
			
			stage.removeChild(enemigo11);
			stage.removeChild(enemigo12);
			stage.removeChild(enemigo13);
			stage.removeChild(enemigo21);
			stage.removeChild(enemigo22);
			stage.removeChild(enemigo23);
			stage.removeChild(enemigo31);
			stage.removeChild(enemigo32);
			
			stage.removeChild(personaje);
			stage.removeChild(bordeSuperior);
			stage.removeChild(bordeInferior);
			stage.removeChild(bordeDerecho);
			stage.removeChild(bordeIzquierdo);
			
			stage.removeChild(mc_vidaCartel);
			stage.removeChild(vidaNumero);
		}
		
		public function presionoTecla(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
					irArriba = true;
					break;
				
				case Keyboard.DOWN:
					irAbajo = true;
					break;
				
				case Keyboard.RIGHT:
					irDer = true;
					break;
				
				case Keyboard.LEFT:
					irIzq = true;
					break;
				
				case Keyboard.ENTER:
					enter = true;
					break;
			}
			
		}
		
		public function soltoTecla(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP:
					irArriba = false;
					break;
				
				case Keyboard.DOWN:
					irAbajo = false;
					break;
				
				case Keyboard.RIGHT:
					irDer = false;
					break;
				
				case Keyboard.LEFT:
					irIzq = false;
					break;
				
				case Keyboard.ENTER:
					enter = false;
					break;
			}
		}
		
		public function moverEnemigos():void
		{
			moverEnemigoDerecha(enemigo11,velocidadPiso1);
			moverEnemigoDerecha(enemigo12,velocidadPiso1);
			moverEnemigoDerecha(enemigo13,velocidadPiso1);
			moverEnemigoIzquierda(enemigo21,velocidadPiso2);
			moverEnemigoIzquierda(enemigo22,velocidadPiso2);
			moverEnemigoIzquierda(enemigo23,velocidadPiso2);
			moverEnemigoDerecha(enemigo31,velocidadPiso3);
			moverEnemigoDerecha(enemigo32,velocidadPiso3);
		}
		
		public function moverEnemigoDerecha(enemigo:Sprite,velocidad:int):void
		{
			enemigo.x += velocidad;
			
			if(enemigo.x > stage.stageWidth + enemigo.width/2 )
			{
				enemigo.x = -enemigo.width / 2;
			}
		}
		
		public function moverEnemigoIzquierda(enemigo:Sprite,velocidad:int):void
		{
			enemigo.x -= velocidad;
			
			if(enemigo.x < -enemigo.width/2 )
			{
				enemigo.x = stage.stageWidth + enemigo.width/2;
			}
		}
		
		public function comprobarColisiones():void
		{
			comprobarColision(personaje,enemigo11);
			comprobarColision(personaje,enemigo12);
			comprobarColision(personaje,enemigo13);
			comprobarColision(personaje,enemigo21);
			comprobarColision(personaje,enemigo22);
			comprobarColision(personaje,enemigo23);
			comprobarColision(personaje,enemigo31);
			comprobarColision(personaje,enemigo32);
			
			comprobarObjetivo(personaje,bordeSuperior);
			
		}
		
		public function comprobarObjetivo (objeto1:Sprite,objeto2:Sprite):void
		{
			if (objeto1.hitTestObject(objeto2))
			{
				etapa = 4;
			}
		}
		
		public function comprobarColision(objeto1:Sprite,objeto2:Sprite):void
		{
			if(objeto1.hitTestObject(objeto2) == true)
			{
				objeto1.x = personajeXInicial;
				objeto1.y = personajeYInicial;
				vida -= 1;
			}
		}
		
		public function comprobarVida():void
		{
			if (vida != vidaInterna)
			{
				stage.removeChild(vidaNumero);
				vidaInterna = vida;
				switch (vida)
				{
					case 1:
						vidaNumero = mc_uno;
						break;
					
					case 2:
						vidaNumero = mc_dos;
						break;
					
					case 3:
						vidaNumero = mc_tres;
						break;
					
					case 0:
						etapa = 3;
						break;
				}
				dibujarVida();
			}
		}
		
		public  function dibujarVida():void
		{
			stage.addChild(vidaNumero);
			vidaNumero.x = stage.stageWidth - 45;
			vidaNumero.y = stage.stageHeight - 10;
		}
		
		public function moverPersonaje():void
		{
			if (irAbajo == true && !personaje.hitTestObject(bordeInferior))
			{
				personaje.y += velocidadPersonaje;
			}
			
			if (irArriba == true)
			{
				personaje.y -= velocidadPersonaje;
			}
			
			if (irDer == true && !personaje.hitTestObject(bordeDerecho))
			{
				personaje.x += velocidadPersonaje;
			}
			
			if (irIzq == true && !personaje.hitTestObject(bordeIzquierdo))
			{
				personaje.x -= velocidadPersonaje;
			}
		}
		
		public function dibujarRectangulo(color:int, opacidad:Number ,ancho:int,alto:int , x:int, y:int):Sprite
		{
			var dj:Sprite = new Sprite();
			
			dj.graphics.beginFill(color, opacidad);
			
			dj.graphics.drawRect(-ancho/2,-alto/2,ancho,alto);
			
			dj.graphics.endFill();
			
			stage.addChild(dj);
			dj.x = x;
			dj.y = y;
			return dj;			
		}
		
	}
}