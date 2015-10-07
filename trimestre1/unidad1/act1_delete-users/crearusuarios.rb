#!/usr/bin/ruby
# encoding : utf-8

fichero=`cat userslist.txt`

usuarios=fichero.split("\n")

usuarios.each do |usuario|
  system("useradd -m -s /bin/bash #{usuario}")
  puts "Usuario #{usuario} creado correctamente"
end

