#!/usr/bin/ruby
# encoding : utf-8

fichero=`cat userslist.txt`

usuarios=fichero.split("\n")

usuarios.each do |usuario|
  system("userdel -r #{usuario}")
  puts "Usuario #{usuario} borrado correctamente"
end


