#!/bin/sh

# Hourly Data Backup
rsync -az --progress --delete --size-only /FECarpetas/Empresas/ 10.183.136.144:/FECarpetas/Empresas/

