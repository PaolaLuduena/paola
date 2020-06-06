// Programacion del funcionamiento del lavarropas en la opcion lavado diario//
// A modo de ejemplo se colocaron sensores de peso de ropa que Vienen de fabrica, y sensores de la puerta//
// También se uso como ejemplo de los 60 minutos del lavado diario a 60 segundos en pseint//
SubProceso kilos(kilos_de_fabrica)
	// Ejemplo de sensor de kilos_de_fabrica,áste calcula el kilo de ropa puesta.
	// En caso de que los kilos, esten fuera de lo permitido, el lavarropas enunciara el error cuando el "pulsador_inicio_apagado este en<-1".
     Escribir 'kilos_de_fabrica<-6';
	Escribir "Kilos_de_fabrica<-5";
	Leer kilos_de_fabrica[1];
FinSubProceso

SubProceso opciones(opcion_1,opcion_2)
	// Ejemplo de bloqueo de la puerta.
	Escribir 'Puerta<-0'; // Estado de la puerta 0<-Abierto
	Escribir 'Puerta<-1'; // Estado de la puerta 1<-Cerrado
	Leer opcion_2[1];
	// Ejemplo de sensor del pulsador_inicio_apagado
	Escribir 'Pulsador_inicio_apagado<-1'; // Estado del pulsador 1<-Prendido
	Leer opcion_1[1];
	
FinSubProceso

Proceso lavarropas
	// Definimos las variables.
	Definir centrifugado Como Entero;
	Definir desagotando Como Entero;
	Definir cargando_agua Como Entero;
	Definir lavando Como Entero;
	Definir contador Como Entero;
	Definir opcion_1 Como Entero;
	Dimension opcion_1[2];
	Definir opcion_2 Como Entero;
	Dimension opcion_2[2];
	Definir kilos_de_fabrica Como Entero;
	Dimension kilos_de_fabrica[2];
	definir presostato Como Entero; //bomba-de_aga,que permite cargar el agua
	Definir enjuague_con_suavizante Como Entero;
	definir enjuagando Como Entero;
	
	
	// inicializado de variables.
	enjuague_con_suavizante<-1;
	enjuagando<-1;
	presostato<-1;
	contador <- 0;
	lavando <- 1;
	centrifugado <- 0;
	desagotando <- 1;
	cargando_agua <- 1;
	
	// Muestra del lavado. 
	Borrar Pantalla;
	Escribir '.........................programación de Lavado dirio....................'; // lavado normal de 60 minutos//
	// llamadas del SubProceso.
	kilos(kilos_de_fabrica);
	Esperar Tecla;
	opciones(opcion_1,opcion_2);
	Esperar Tecla;
	
	Limpiar Pantalla;
	Si opcion_1[1]=1 & opcion_2[1]=1 Entonces
		Si kilos_de_fabrica[1]=6 o kilos_de_fabrica[1]=5 Entonces
			Para contador<-0 Hasta 2 Hacer // Aca comienza el cargado de agua una vez cerrado la puerta,Y pulsador sea iniciado.
				// solo contador cambiara de posicion.
				Si contador=0 & presostato =1 Entonces 
					Escribir '------------Primer Ciclo-------------------';
					Escribir 'Cargando agua'; // iniciando carga de agua,en este caso el cargado_agua estara en posicion 1 siempre.
					Escribir 'Esperar 3 segundo';
					Esperar 3 Segundo;
					Escribir '';
				FinSi
				Si contador=1 & presostato =1 Entonces // iniciando  segundo cargado de agua.
					Escribir '-----------Segundo Ciclo---------------------';
					Escribir 'Cargando agua';
					Escribir 'Esperar 3 segundo';
					Esperar 3 segundos;
					Escribir '';
				FinSi
				Si contador=2 & presostato=1 Entonces // iniciando tercer cargado de agua.
					Escribir '------------Tercer Ciclo----------------------';
					Escribir 'Cargando agua';
					Escribir 'Esperar 3 segundo';
					Esperar 3 segundos;
					Escribir '';
				FinSi
				Si cargando_agua=1 Y contador=0 Entonces
					Escribir 'Lavando'; // iniciando lavado normal.
					Escribir 'Esperar 24 segundo'; 
					Esperar 24 Segundo;
					Escribir '';
				FinSi
				Si cargando_agua=1 & contador=1 Entonces // inicio de enjuagado.
					Escribir 'Enjuagando';
					Escribir 'Esperar 6 segundo';
					Esperar 6 Segundo;
					Escribir '';
				FinSi
				Si cargando_agua=1 & contador=2 Entonces
					Escribir 'Enjuage con suavisante'; // enjuagando_con_suavizante.
					Escribir 'Esperar 4 segundo';
					Esperar 4 Segundo;
					Escribir '';
				FinSi
				Si lavando=1 Y contador=0 Entonces
					Escribir 'Desagotando'; // primer desagote.
					Escribir 'Esperar 3 segundo';
					Esperar 3 Segundo;
					Escribir '';
				FinSi
				Si enjuagando=1 & contador=1 Entonces
					Escribir 'Desagotando'; // segundo desagote.
					Escribir 'Esperar 3 segundo;';
					Esperar 3 Segundo;
					Escribir '';
				FinSi
				Si enjuague_con_suavizante =1 & contador=2 Entonces
					Escribir 'Desagotando'; // tercer desagote.
					Escribir 'Esperar 3 segundo';
					Esperar 3 segundos;
					Escribir '';
				FinSi
				Si desagotando=1 Y contador=1 Entonces // comienzo centrifugado corto
					Escribir 'Centrifugando';
					Escribir 'Espear 3 segundo';
					Esperar 3 segundos;
					Escribir '';
				FinSi
				Si desagotando=1 Y contador=2 Entonces // segundo centrifugado largo.
					Escribir 'Centrifugando';
					Escribir 'Esperar 5 segundo';
					Esperar 5 Segundo;
					Escribir '';
				FinSi
				Si centrifugado=0 Y contador=2 Entonces // si centrifugado esta en posicion 0, que el proceso termino ,el sensor toma el valor,desconecta el pulsador_inicio_apagado y desbloquea la puerta una vez pasados los segundos de Espera.
					Escribir '---------Espere una vez Permitido Abrir---------';
					Escribir '';
					Esperar 4 Segundo;
				     Escribir "Puede Abrir";             
					Esperar Tecla; 
				finsi
					
			FinPara
		SiNo
			Escribir 'Error kilos de mas';
		FinSi
	SiNo
		Escribir 'Error 4 puerta mal cerrada';
	FinSi
FinProceso

