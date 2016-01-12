#!/usr/bin/ruby
#!encoding: utf-8
#Autor: Héctor Pedraza Aguilar

require 'rainbow'

idcompleto=`id -u`

id=idcompleto.to_i

if id != 0
  puts "Tiene que ser usuario root"
  exit
end

=begin
# ALTERNATIVA PARA UTILIZAR NOMBRE EN VEZ DE UID
usuariocompleto = `whoami`
usuario = usuariocompleto.chop

if usuario != "root"
...
=end

fichero=`cat software-list.txt`

filas = fichero.split("\n")

=begin
##### SIN COMPROBACIÓN DE SISTEMA OPERATIVO #####
filas.each do |fila|
  campos = fila.split(":")
  paquete = `dpkg -l | grep "#{campos[0]}  " | grep "^ii "`
  case campos[1]
	when 'i','install'
	  if paquete == ""
		puts "Instalando #{campos[0]}"
		`apt-get install #{campos[0]} -y`
		puts "#{campos[0]} instalado"
	  else
		puts "El paquete #{campos[0]} ya se encuentra instalado"
	  end
	when 'r','remove'
	  if paquete == ""
		puts "El paquete #{campos[0]} no se encuentra instalado"
	  else
		puts "Desinstalando #{campos[0]}"
		`apt-get purge #{campos[0]} -y
		puts "#{campos[0]} desinstalado"`
	  end
	else
	  puts "Orden no reconocida: #{campos[1]}"
	end
end
=end

version = `cat /etc/issue`
versiondc = version.downcase
distro = "unrecognized"

if ((versiondc.include? "debian") || (versiondc.include? "ubuntu"))
  distro = "debian"
  puts "Distro = #{distro}"
else if (versiondc.include? "opensuse")
  distro = "opensuse"
  puts "Distro = #{distro}"
  end
end
case distro
  when "debian"
    filas.each do |fila|
      campos = fila.split(":")
	  paquete = `dpkg -l | grep "#{campos[0]}  " | grep "^ii "`
      case campos[1]
	    when 'i','install'
	      if paquete == ""
		    puts "Instalando #{campos[0]}"
		    `apt-get install #{campos[0]} -y`
		    puts Rainbow("#{campos[0]} instalado").color(:green)
	      else
		    puts Rainbow("El paquete #{campos[0]} ya se encuentra instalado. No se instalará.").color(:yellow)
	      end
	    when 'r','remove'
	      if paquete == ""
		    puts Rainbow("El paquete #{campos[0]} no se puede eliminar ya que no se encuentra instalado").color(:yellow)
	      else
		    puts "Desinstalando #{campos[0]}"
		    `apt-get purge #{campos[0]} -y`
		    puts Rainbow("#{campos[0]} desinstalado").color(:red)
	      end
	    else
	      puts "Orden no reconocida: #{campos[1]}"
	    end
    end
  
  when "opensuse"
    filas.each do |fila|
      campos = fila.split(":")
	  paquete = `zypper search -i | grep "#{campos[0]}  "` 
      case campos[1]
  	    when 'i','install'
	      if paquete != ""
	        puts Rainbow("El paquete #{campos[0]} no se puede instalar, ya está instalado.").color(:yellow)
	      else
			puts "Instalando #{campos[0]}"
		    `zypper --non-interactive install #{campos[0]}`
		    puts Rainbow("#{campos[0]} instalado").color(:green)
		  end
	    when 'r','remove'
	      if paquete == ""
		    puts Rainbow("El paquete #{campos[0]} no se puede eliminar ya que no se encuentra instalado.").color(:yellow)
	      else
	        puts "Desinstalando #{campos[0]}"
		    `zypper --non-interactive remove #{campos[0]}`
		    puts Rainbow("#{campos[0]} desinstalado").color(:red)
	      end
	    else
	      puts "Orden no reconocida: #{campos[1]}"
	    end
    end
  
  else
    puts "Sistema operativo no reconocido. El programa terminará su ejecución."
	exit
  end
