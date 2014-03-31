#!/bin/bash

# loop & print a folder recusively, facturacionelectronica
print_folder_recurse_FE() {
    for i in "$1"/*;do
        if [ -d "$i" ];then
            echo "dir: $i"
            #print_folder_recurse "$i"
        elif [ -f "$i" ]; then
          #echo "file: $i"
	  IFS='/'
	  read -a array <<< "$i"
	  #echo "${array[5]}"  	
	  IFS='.'
	  read -a arr <<< "${array[5]}"
	  echo "${arr[0]}"
	  mysql -uroot -pD0cd1g2o12 facturacionelectronica2011 -e "load data local infile '$i' into table ${arr[0]} fields terminated by '|' enclosed by '\'' lines terminated by '~'"
        fi
    done
}

# loop & print a folder recusively, hmailserver
print_folder_recurse_HM() {
    for i in "$1"/*;do
        if [ -d "$i" ];then
            echo "dir: $i"
            #print_folder_recurse "$i"
        elif [ -f "$i" ]; then
          #echo "file: $i"
          IFS='/'
          read -a array <<< "$i"
          #echo "${array[5]}"
          IFS='.'
          read -a arr <<< "${array[5]}"
          echo "${arr[0]}"
	  mysql -uroot -pD0cd1g2o12 hmailserver -e "load data local infile '$i' into table ${arr[0]} fields terminated by '|' enclosed by '\'' lines terminated by '~'"
        fi
    done
}

## Facturacionelectronica2011 Nodo 1
path=""
if [ -d "$1" ]; then
    path=$1;
else
    path="/home/data/Replica/Nodo3/facturacionelectronica"
fi
echo "Importando primer nodo facturacionelectronica2011 from: $path"
print_folder_recurse_FE $path



## hmailserver from nodo 1
path=""
if [ -d "$1" ]; then
    path=$1;
else
    path="/home/data/Replica/Nodo3/hmailserver"
fi
echo "Importando primer nodo hmailserver from: $path"
print_folder_recurse_HM $path


##Facturacionelectronica Nodo 2
path=""
if [ -d "$1" ]; then
    path=$1;
else
    path="/home/data/Replica/Nodo4/facturacionelectronica"
fi
echo "Importando segundo nodo facturacionelectronica2011 from: $path"
print_folder_recurse_FE $path


##Hmailserver Nodo 2
path=""
if [ -d "$1" ]; then
    path=$1;
else
    path="/home/data/Replica/Nodo4/hmailserver"
fi
echo "Importando segundo nodo Hmailserver from: $path"
print_folder_recurse_HM $path