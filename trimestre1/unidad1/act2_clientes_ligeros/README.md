Administración de sistemas operativos

Práctica 1.02 - Clientes ligeros con LTSP

1. Introducción

El objetivo de esta práctica es implementar un sistema de clientes ligeros mediante la herramienta LTSP. Para realizarla utilizaremos una máquina lubuntu 14.04. de 64 bits como servidor del LTSP.

Para que el sistema funcione, la máquina servidor y las máquinas cliente tienen que estar dentro de la misma red interna, única para estos equipos. Por tanto, configuraremos la tarjeta de red principal para salida a internet como es costumbre y añadiremos una segunda tarjeta de red a la máquina, que conectaremos a la red interna con los equipos clientes. 

Nota: el tipo de adaptador que le pongamos debe de ser indiferente, aunque en algunos casos el servidor dhcp solo funcionaba con adaptadores de tipo PCnet-FAST III.

2. Configuración del servidor

Instalamos la máquina virtual con las configuraciones por defecto. Una vez concluya la instalación ejecutaremos algunos comandos para resumir la instalación que se ha realizado.

![imagen1] (./imagenes/1-01-comandos_lubuntu.png)

A continuación vamos a crear tres usuarios, que serán los que posteriormente accedan a los clientes ligeros.

![imagen2] (./imagenes/1-02-usuarios_creados.png)

Ahora vamos a instalar la herramienta que vamos a utilizar, aunque antes vamos a instalar el servicio ssh para que el profesor pueda revisar las configuraciones realizadas desde remoto: apt-get install openssh-server

Ahora si vamos a instalar el servicio ltsp. Ejecutamos el comando apt-get install ltsp-server-standalone .

Cuando termine de instalarse tendremos que crear una imagen del sistema, que será a partir de la cual arrancarán los clientes ltsp. Para ello ejecutamos el comando ltsp-build-client.
Una vez que tengamos 