#!/usr/bin/ruby
#!encoding: utf-8
#Autor: Héctor Pedraza Aguilar

require 'rainbow'

def procesarFila(fila)
  campos = fila.split(":")
  buscar = `ps -ef | grep #{campos[0]} | grep -v grep | awk '{print $2}'`
  pids = buscar.split("\n")
  case campos[1]
    when "kill"
	  if buscar != ""
	    pids.each do |pid|
	      ejecucion = system("kill -9 #{pid}")
		  if ejecucion
		    puts Rainbow("_KILL_: Proceso #{campos[0]} (pid #{pid}) eliminado").color(:red)
		  else
		    puts "Error. No se pudo eliminar el proceso #{campos[0]} (pid #{pid})"
		  end
        end
      end
    when "notify"
	  if buscar != ""
	    puts Rainbow("NOTICE: Proceso #{campos[0]} en ejecución").color(:green)
	  end
    else 
	  puts Rainbow("Orden no reconocida: #{campos[1]}").color(:yellow)
  end
end

idcompleto=`id -u`

id=idcompleto.to_i

if id != 0
  puts "Tiene que ser usuario root para poder ejecutar el script."
  exit
end

crear = system("touch state.running")

if !crear
  puts Rainbow("No se pudo crear el fichero de control. Ejecución abortada.").color(:red)
  exit
end

fichero=`cat processes-black-list.txt`

filas = fichero.split("\n")

while `ls |grep state.running` != "" do 
  filas.each do |fila|
    procesarFila(fila)
  end
  sleep(5)
end
