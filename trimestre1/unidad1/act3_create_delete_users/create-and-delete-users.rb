# !/usr/bin/ruby
# !encoding: utf-8

usuario=`whoami`

if usuario != "root"
  puts "Tiene que ser usuario root"
  exit
end

fichero=`cat userslist.txt`
filas=fichero.split("\n")

filas.each do |fila|
  datos=fila.split(":")
  if datos[-1] == "add"
    system("useradd -m -s /bin/bash #{campos[0]})
  else
    system("userdel -r #{campos[0]})
  end 
end
