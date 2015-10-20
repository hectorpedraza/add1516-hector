#!/usr/bin/ruby
#!encoding: utf-8

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

fichero=`cat userslist.txt`

filas = fichero.split("\n")

filas.each do |fila|
  campos=fila.split(":")
  if campos[2] != ""
    if campos[-1] == "add"
	  puts "Añadiendo el usuario #{campos[0]}"
      system("useradd -m -s /bin/bash #{campos[0]}")
    else if campos[-1] == "delete"
          puts "Borrando el usuario #{campos[0]}"
          system("userdel -r #{campos[0]}")
		end
    end
  else
    puts "El cliente #{campos[0]} no tiene correo"
  end
end
