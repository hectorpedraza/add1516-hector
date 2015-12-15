# Administración de sistemas operativos

# Práctica 3.01 - LDAP




## 1. Servidor LDAP - OpenSUSE

### 1.1 Preparación de la práctica

Antes de empezar, vamos a preparar la máquina con las herramientas que necesitamos para desarrollar la práctica.

Configuramos la máquina servidor tal y como nos indica el enunciado y ejecutamos los siguientes comandos para comprobarlo:

![imagen001](./imagenes/0-01-conf_server.png)

También tenemos que editar, el fichero /etc/hosts para agregar los nombres e ip de las otras 2 máquinas.

![imagen002](./imagenes/0-02-hosts.png)



### 1.2 Instalación del servidor LDAP

Comenzaremos la práctica instalando el servicio LDAP en el servidor. Para ello tenemos que instalar el paquete OpenLDAP. Como además queremos aprovechar la funcionalidad del YaST de OpenSUSE, instalaremos también los módulos de configuración para LDAP, que se llaman `yast2-auth-client` y `yast2-auth-server`.

![imagen101](./imagenes/1-01-instalacion.png)

Una vez instalados los paquetes abrimos la herramienta YaST y ejecutamos el servidor de autenticación. Es posible que al intentar ejecutar el servicio nos obligue a instalar el protocolo de seguridad Kerberos. Aceptamos y comenzaremos a configurar el servicio.

![imagen102](./imagenes/1-02-kerberos.png)

![imagen103](./imagenes/1-03-conf_inicial.png)

![imagen104](./imagenes/1-04-conf_inicial2.png)

![imagen105](./imagenes/1-05-conf_inicial3.png)

![imagen106](./imagenes/1-06-conf_inicial4.png)

![imagen107](./imagenes/1-07-servicio_activo.png)


### 1.3 Crear usuarios y grupos en LDAP



![imagen200](./imagenes/2-00-gq.png)

![imagen201](./imagenes/2-01-usuarios.png)

![imagen202](./imagenes/2-02-creacion_usuario.png)

![imagen203](./imagenes/2-03-grupos.png)

![imagen204](./imagenes/2-04-creacion_grupos.png)

![imagen205](./imagenes/2-05-ou_establecido.png)

![imagen206](./imagenes/2-06-slapcat.png)


### 1.4 Autenticación

![imagen301](./imagenes/3-01-autentication_client.png)

![imagen302](./imagenes/3-02-conexion_local.png)


## 2. Otro equipo

### 2.1 Preparativos

![imagen401](./imagenes/4-01-conf_cliente.png)

![imagen402](./imagenes/4-02-etc_hosts.png)


### 2.2 Configuración

![imagen403](./imagenes/4-03-instalacion_cliente.png)


## 3. Conclusiones

