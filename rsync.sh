#!/bin/sh

# Hourly Data Backup
rsync -az --progress --delete --size-only /FECarpetas/Empresas/ 10.183.136.144:/FECarpetas/Empresas/

####para agregarlo al crontab
# shell$ crontab -e
#0 * * * * /root/FESync.sh