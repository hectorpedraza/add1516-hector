# Administración de sistemas operativos

# Práctica 1.02 - Clientes ligeros con LTSP

## 1. Introducción

El objetivo de esta práctica es implementar un sistema de clientes ligeros mediante la herramienta LTSP. Para realizarla utilizaremos una máquina ubuntu 14.04 de 32 bits como servidor del LTSP.

Para que el sistema funcione, la máquina servidor y las máquinas cliente tienen que estar dentro de la misma red interna, única para estos equipos. Por tanto, configuraremos la tarjeta de red principal para salida a internet como es costumbre y añadiremos una segunda tarjeta de red a la máquina, que conectaremos a la red interna con los equipos clientes. 

> **Nota:** el tipo de adaptador que le pongamos debe de ser indiferente, aunque en algunos casos el servidor dhcp solo funcionaba con adaptadores de tipo PCnet-FAST III.

## 2. Configuración del servidor

Instalamos la máquina virtual con las configuraciones por defecto. Una vez concluya la instalación ejecutaremos algunos comandos para resumir la instalación que se ha realizado.

![imagen101] (./imagenes/1-01-comandos_ubuntu.png)

A continuación vamos a crear tres usuarios, que serán los que posteriormente accedan a los clientes ligeros.

![imagen102] (./imagenes/1-02-usuarios_creados.png)

Ahora vamos a instalar la herramienta que vamos a utilizar, aunque antes vamos a instalar el servicio ssh para que el profesor pueda revisar las configuraciones realizadas desde remoto: apt-get install openssh-server

Ahora si vamos a instalar el servicio ltsp. Ejecutamos el comando apt-get install ltsp-server-standalone .

Cuando termine de instalarse tendremos que crear una imagen del sistema, que será a partir de la cual arrancarán los clientes ltsp. Para ello ejecutamos el comando `ltsp-build-client`.

> **Nota:** si tenemos un sistema de 64 bits y el cliente es de 32 tenemos que especificarlo en el comando de creación de la imagen la siguiente manera: `ltsp-build-client --arch i386`.

Una vez que tengamos la imagen construida tenemos que modificar algunos archivos de configuración para que la comunicación entre el servidor y los clientes funcionen.

El primer fichero que tenemos que modificar está en "/etc/default/isc-dhcp-server", en el cual tenemos que modificar la última línea para especificar la interfaz que va a dar servicio dhcp, que en nuestro caso es la que esta conectada a la red interna.

![imagen103] (./imagenes/1-03-interfaz_dhcp.png)

El siguiente fichero que tenemos que editar es "/etc/ltsp/dhcpd.conf", el cual debe quedar de la siguiente manera (descomentamos la línea next-server):

![imagen104] (./imagenes/1-04-dhcp_conf.png)

Por último, modificamos el fichero "/etc/default/tftpd-hpa", donde tenemos que modificar la dirección de la interfaz con la que conectarán los clientes en la red interna.

![imagen105] (./imagenes/1-05-tftpd_conf.png)

## 3. Conexión con los clientes

En este último paso vamos a establecer la conexión de los clientes con el servidor. 

En primer lugar nos creamos una máquina virtual, sin disco duro ni unidad de CD conectadas. Lo único que tenemos que configurar será el tipo de arranque para incluir el arranque por red y ponerlo en primer lugar en el orden de arranque.

![imagen201] (./imagenes/2-01-configuracion_cliente.png)

También tenemos que poner la interfaz de red en modo red interna para que funcione el sistema implementado.

Arrancamos la máquina virtual del cliente. En este punto es posible que se den dos casos. En el primero de los casos, todo ha ido bien y la máquina cliente arranca sin problemas. En el segundo caso, que es el que se nos ha dado, la máquina no arranca sino que devuelve el siguiente mensaje.

![imagen202] (./imagenes/2-02-no_dhcp.png)

Este mensaje nos indica que la máquina no puede arrancar porque no hay ningún servidor dhcp activo en la red. En nuestro caso se debe a que el servidor no está arrancando el servicio correctamente y no permite el arrancado del servicio por causas totalmente desconocidas. La solución tomada fué ejecutar el demonio del servicio directamente en la consola. Para ver el comando de ejecución podemos buscar la línea que lo invoca en el script del servicio ("/etc/init.d/isc-dhcp-server).

![imagen203] (./imagenes/2-03-dhcp_arrancado.png)

Una vez ejecutado el demonio (lo podemos comprobar con el comando `ps -ef`), volvemos a arrancar la máquina cliente.

En este caso vemos que la configuración de red se establece correctamente pero el cliente no consigue traer la imagen de la máquina por ftp. 

![imagen204] (./imagenes/2-04-no_tftp.png)

En nuestro caso vuelve a deberse a que el servicio no se arranca correctamente, igual que el dhcp. Realizamos la misma activación manual del demonio.

![imagen205] (./imagenes/2-05-tftpd_arrancado.png)

Volvemos a arrancar la máquina cliente y, ahora sí, carga toda la configuración correctamente.

![imagen206] (./imagenes/2-06-cliente_iniciado.png)

Nos logueamos con cualquiera de los usuarios que creamos anteriormente y entraremos en el escritorio del sistema. Abrimos una terminal y ejecutamos algunos comandos de comprobación para verificar que realmente es como si estuviéramos ejecutando la máquina "dentro" del servidor ltsp.

![imagen207] (./imagenes/2-07-comprobacion_cliente.png) 

## 4. Aclaraciones de la práctica

La práctica ha planteado varios inconvenientes. El primero de ellos ha sido el sistema operativo elegido. En un primer lugar se decidió utilizar lubuntu, ya que el escritorio ligero lxde sobrecargaría menos las máquinas clientes, pero realizando la práctica con esta distribución, el cliente nunca llega a cargar el escritorio. Siempre se queda colgada al hacer login. 
Las distribuciones comprobadas con las que ha funcionado el servicio han sido ubuntu y xubuntu, tanto de 32 bits como de 64.

Otro inconveniente han sido los servicios relacionados con el ltsp, ya que por algún motivo que aún se desconoce, en algunos equipos no se arrancaban adecuadamente, impidiendo la conexión de los clientes.

En definitiva, la recomendación para esta práctica es realizarla con un sistema xubuntu, ya que es el que menos problemas ha ocasionado y no sobrecarga los clientes de manera excesiva con su entorno de escritorio.

## 5. Conclusiones

Los clientes ligeros resultan una solución bastante útil en el caso de que tengamos equipos antiguos que no dispongan de disco duro y necesitemos algunos equipos para usos básicos, como puede ser en un aula o en una oficina de poco uso. La pega que esto puede tener son las limitaciones que el propio hardware ofrezca y la sobrecarga que se pueda dar en el ordenador que actúe como servidor. Aún así resulta una solución más que viable para ciertos casos concretos.

En cuanto a la práctica sería interesante resolver los problemas surgidos con algunas de las distribuciones utilizadas, incluso realizar un estudio para buscar aquellas distribuciones que mejor optimicne los recursos de los que se disponga (principalmente reduciendo el uso de memoria para el sistema en los clientes). También sería interesante comprobar si este sistema (o análogo) sería viable en un entorno windows y poder probarlo.