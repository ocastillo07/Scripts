#!/bin/sh

echo "Iniciando backup"
hour="$(date '+%H:%M:%S')"
mysqldump --opt --skip-add-locks --user=USER --password=PASSWD dbname | gzip > /home/backups/FE_`date "+%Y-%m-%d"`_$hour.zip
echo "Montando cfiles"
/home/cloudfuse/cloudfuse /home/cfiles/
if [ $? = "1" ]; then
        echo "Desmontando cfiles"
        umount -l /home/cfiles/
        echo "Montando cfiles"
        /home/cloudfuse/cloudfuse /home/cfiles/
	if [ $? = "1" ]; then
        	echo "Error al montar CFiles"
	fi
fi
echo "Copiando backup a Cloud Files"
cp /home/backups/FE_`date "+%Y-%m-%d"`_$hour.zip /home/cfiles/RespaldoBaseDatos/FE_`date "+%Y-%m-%d"`_$hour.zip
if [ $? = "1" ]; then
        echo "Error al copiar el archivo"
fi
echo "Copia a Cfiles terminado"
echo "Desmontando cfiles"
umount -l /home/cfiles/
echo "Eliminando respaldos viejos"
find /home/backups/ -name 'FE_20*' -mtime +5 | xargs /bin/rm -f
echo "Fin"