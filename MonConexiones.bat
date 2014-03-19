@echo off

tasklist /s App01 /u administrator /p D0ct0s0618! /FI "IMAGENAME eq wd150session.exe" | find /I /C "wd150session.exe" > C:\Monitoreo\app1.txt
tasklist /s App03 /u administrator /p D0ct0s0618# /FI "IMAGENAME eq wd150session.exe" | find /I /C "wd150session.exe" > C:\Monitoreo\app3.txt
tasklist /s App04 /u administrator /p D0ct0s0618$ /FI "IMAGENAME eq wd150session.exe" | find /I /C "wd150session.exe" > C:\Monitoreo\app4.txt
tasklist /s App05 /u administrator /p D0ct0s0618%% /FI "IMAGENAME eq wd150session.exe" | find /I /C "wd150session.exe" > C:\Monitoreo\app5.txt
set /p app01=<C:\Monitoreo\app1.txt
set /p app03=<C:\Monitoreo\app3.txt
set /p app04=<C:\Monitoreo\app4.txt
set /p app05=<C:\Monitoreo\app5.txt
del C:\Monitoreo\app1.txt
del C:\Monitoreo\app3.txt
del C:\Monitoreo\app4.txt
del C:\Monitoreo\app5.txt

set /a total = %app01%+%app03%+%app04%+%app05%

echo Time				App01	App03	App04	App05	Total>> C:\inetpub\wwwroot\conexiones.txt
set datetimef=%date:~-4%-%date:~7,2%-%date:~4,2% %time:~0,2%:%time:~3,2%:%time:~6,2%

echo %datetimef% 		%app01%	%app03%	%app04%	%app05%	%total%>> C:\inetpub\wwwroot\conexiones.txt
