# Administración de sistemas operativos

# Práctica 4.01 - Tareas programadas

El objetivo de esta práctica consiste en tomar contacto con las herramientas de programación de tareas, tanto en linux (OpenSUSE) como en windows (Windows 7).

Como sabemos, podemos configurar varios tipos de tareas en función del momento en que queramos que se ejecuten: tareas diferidas, tareas periódicas y tareas asíncronas. En nuestro caso programaremos una tarea de cada tipo.


## 1. S.O. OpenSUSE

Comenzaremos realizando la práctica en OpenSUSE.


### 1.1 Configuración de la máquina

Lo primero que tenemos que hacer es establecer la configuración de red de la máquina tal y como viene en el enunciado. La configuración resultante es la siguiente.

![imagen101](./imagenes/1-01-configuracion_maquina.png)


### 1.2 Tarea diferida

Comenzaremos a programar tareas con la más sencilla: la tarea diferida. En nuestro caso vamos a especificar una tarea diferida que realice un apagado (`shutdown`) de la máquina en el momento que le especifiquemos.

Para este tipo de tareas tenemos la herramienta `at`. Lo primero que tenemos que asegurarnos es que el servicio de at se encuentra arrancado (demonio "atd"). 

Una vez comprobado, tenemos que ejecutar el comando `at` en la terminal, con los parámetros indicando la fecha y hora a la que queremos que se ejecute la tarea. Ejecutamos y nos aparece una nueva línea de comandos donde introduciremos la secuencia de comandos que ejecutará la tarea programada. Indicamos el comando `shutdown` y pulsamos CTRL+D para terminar.

![imagen102](./imagenes/1-02-at_shutdown.png)

Como vemos, cuando llega la hora indicada se ejecuta automáticamente la secuencia de comandos de la tarea.

**Nota**: Si queremos comprobar el listado de tareas diferidas activas podemos ejecutar el comando `at -l`.

### 1.3 Tarea periódica

Seguimos con la tarea periódica. Este tipo de tareas se ejecutará de forma repetitiva según las indicaciones que se le pasen. Por ejemplo, que se ejecute a las y media de cada hora, o el día 1 de cada mes. 

Para este tipo de tareas tenemos la herramienta `cron`. Esta herramienta nos permite almacenar un registro de tareas para cada usuario y programar la repetición de dichas tareas.

En nuestro caso vamos a crear una tarea periódica que se ejecute cada hora y escriba la hora del sistema en un fichero de "log" creado por nosotros. Para agregar la tarea al cron tenemos que ejecutar el comando `crontab -e`. Este comando nos crea un registro cron de tareas para el usuario con el que ejecutemos el comando o, si ya estaba creado, nos permite editarlo. 

Abrimos el registro y agregamos la línea correspondiente para que ejecute el script con las instrucciones que queremos.

![imagen103](./imagenes/1-03-crontab.png)

**Nota**: si queremos listar las tareas de un registro crontab podemos utilizar el comando `crontab -l`. Del mismo modo podemos borrar el listado completo con el comando `crontab -r`.


### 1.4 Tarea asíncrona

Terminamos con la definición de una tarea asíncrona. En este caso también utilizaremos la herramienta cron, ya que dispone de unos directorios específicos dentro de la carpeta `/etc` donde podemos guardar los scripts de órdenes que queramos que se ejecuten periódicamente y de forma asíncrona.

En nuestro caso crearemos un script que, diariamente, actualice los repositorios de descarga y actualice los programas instalados. Por tanto, tenemos que crear el script (recordar darle permisos de ejecución) e incluirlo en el directorio `/etc/cron.daily`.

![imagen104](./imagenes/1-04-cron_daily.png)

**Nota**: del mismo modo, tenemos directorios equivalentes al `cron.daily` para ejecuciones cada hora, semanalmente o mensualmente.



## 2. Windows

Ahora vamos a realizar las mismas configuraciones pero en la máquina Windows. En este caso no requerimos de utilizar varias herramientas. El sistema incluye la herramienta `Programador de tareas` que permite configurar las tareas de forma diferida, periódica o asíncrona según queramos.

Podemos encontrar esta herramienta en `Panel de control -> Herramientas administrativas -> Programador de tareas`. En el programador de tareas podemos crear la tarea a varios niveles, según las agrupaciones que queramos hacer. En nuestro caso vamos a incluirlas todas como tareas de windows.


### 2.1 Configuración de la máquina

Antes de ponernos con las tareas, vamos a establecer la configuración de red como corresponde.

![imagen201](./imagenes/2-01-configuracion_red.png)


### 2.2 Tarea diferida

Empezamos nuevamente con la tarea diferida. Vamos a definir una tarea de apagado del equipo. Para ello vamos a `Crear tarea básica` en el menú de la derecha y nos aparece un cuadro de diálogo donde comenzaremos a establecer la configuración.

Empezamos configurando el nombre y descripción de la tarea, junto con el sistema operativo en el que se ejecutará la misma y continuamos.

![imagen202](./imagenes/2-02-tarea_diferida1.png)

En la siguiente pantalla tenemos que definir el o los desencadenadores que dispararán la tarea. Creamos uno nuevo y vamos a indicarle que se ejecute unos pocos minutos después de que definamos la tarea, para poder comprobar su funcionamiento. Si la hora indicada ya ha pasado no se ejecutará hasta el día siguiente. Indicamos también que se ejecute una única vez.

![imagen203](./imagenes/2-03-tarea_diferida2.png)

En la siguiente pantalla indicaremos la acción o acciones que se ejecutarán cuando se dispare la tarea. En este caso vamos a realizar un apagado del sistema, por lo que creamos una acción y elegimos `Iniciar un programa` e indicamos el comando correspondiente, `shutdown /s`.  

![imagen204](./imagenes/2-04-tarea_diferida3.png)

Aceptamos, finalizamos la configuración, y esperamos a que llegue la hora indicada en la tarea. Si todo ha ido bien, nos aparecerá la advertencia de que el equipo se apagará en menos de 1 minuto.

![imagen205](./imagenes/2-05-tarea_diferida4.png)


### 2.3 Tarea periódica

Ahora pasamos a la tarea periódica. Vamos a programar una tarea que lance un mensaje de aviso diario a una hora concreta. 

Como antes, creamos una nueva tarea y seguimos los mismos pasos que anteriormente. Empezamos indicando nombre, descripción y sistema operativo. 

![imagen206](./imagenes/2-06-tarea_periodica1.png)

Luego pasamos a los desencadenadores. En este caso seleccionamos la ejecución diaria y a una hora cercana, para comprobar el funcionamiento de la tarea. 

![imagen207](./imagenes/2-07-tarea_periodica2.png)

La acción que vamos a provocar es el lanzamiento de un mensaje en pantalla. Por lo cual, elegimos `Mostrar un mensaje` e indicamos el texto que queramos mostrar. 

![imagen208](./imagenes/2-08-tarea_periodica3.png)

Dejamos el resto de datos sin modificar y finalizamos. Cuando llegue la hora indicada, si la configuración es la correcta, aparecerá el mensaje en pantalla.

![imagen209](./imagenes/2-09-tarea_periodica4.png)


### 2.4 Tarea asíncrona

Para terminar, definiremos una tarea asíncrona. En nuestro caso vamos a indicar una tarea que se repita varias veces a la semana y que haga una copia de seguridad de una carpeta específica. La ejecución la indicaremos mediante un script ".bat", que contendrá el comando de copia de seguridad.

Seguimos los mismos pasos que anteriormente: creamos la nueva tarea e indicamos nombre, definición y sistema. Opcionalmente, según la idea que tengamos para la tarea, podemos indicar que el script se ejecute aún cuando el usuario no tenga la sesión iniciada.

![imagen210](./imagenes/2-10-tarea_asincrona1.png)

Como desencadenador indicaremos una repetición de determinado días de la semana. Volvemos a indicar una hora próxima para comprobar el funcionamiento de la tarea.

![imagen211](./imagenes/2-11-tarea_asincrona2.png)

La acción en este caso será `Iniciar un programa`, e indicaremos la ruta donde se encuentra el script que se ha de ejecutar.

![imagen212](./imagenes/2-12-tarea_asincrona3.png)

La diferencia de este caso con respecto de las tareas anteriores reside en la última pestaña de la configuración. Aquí, tenemos que marcar tanto el reinicio de la tarea en caso de que no se ejecute como el intento de ejecución lo antes posible si no se cumplió el inicio programado.

![imagen213](./imagenes/2-13-tarea_asincrona4.png)

Cuando pase la hora indicada, comprobamos que se ha ejecutado el script, que en nuestro caso simplemente copia los ficheros de la carpeta indicada a una nueva mediante el comando de windows `xcopy`.

![imagen214](./imagenes/2-14-tarea_asincrona5.png)



## 3. Conclusiones

El uso de las tareas programadas aporta una gran utilidad claramente apreciable. Podemos preparar aquellas tareas que, por cualquier causa, no podamos ejecutar manualmente cuando así se requiera. Además, como administradores de sistemas resulta fundamental, ya que el número de tareas que deben de realizarse y tenerse controladas es demasiado numeroso y requieren de unas condiciones que impiden su ejecución manual.

Analizando la práctica, parece que en el caso de windows la definición de las tareas programadas resulta algo más sencilla e intuitiva que en el caso de linux. Si bien algunas de las opciones concretas no son muy claras, la interfaz del programador de tareas y el hecho de centralizar todas las tareas independientemente del tipo de tarea que se quiera realizar facilita su uso en este sistema. En linux, en cambio, debemos acostumbrarnos a una sintaxis específica a utilizar en cada uno de los casos, ademas de tener que recurrir a herramientas distintas en función de la tarea que queramos programar.

A pesar de esto, el desarrollo de tareas programadas no resulta complejo en ninguno de los casos. La complejidad reside completamente en el tipo de acción que queramos programar.