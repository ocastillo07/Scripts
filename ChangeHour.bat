@echo off

set minutos=%time:~3,2%
set seconds=%time:~6,2%

for /f "tokens=1,2 delims= " %%A in ('time /t') do set CTIME=%%A & set AMPM=%%B
for /f "tokens=1,2 delims=:" %%C in ('echo %CTIME%') do set HOURS=%%C& set MINS=%%D

if %AMPM%==PM (
  if %HOURS% == 01 (set HOURS=13)
  if %HOURS% == 02 (set HOURS=14)
  if %HOURS% == 03 (set HOURS=15)
  if %HOURS% == 04 (set HOURS=16)
  if %HOURS% == 05 (set HOURS=17)
  if %HOURS% == 06 (set HOURS=18)
  if %HOURS% == 07 (set HOURS=19)
  if %HOURS% == 08 (set HOURS=20)
  if %HOURS% == 09 (set HOURS=21)
  if %HOURS% == 10 (set HOURS=22)
  if %HOURS% == 11 (set HOURS=23)
  ) ELSE (
  if %HOURS% == 12 (set HOURS=00)
  ) 

set DSTAMP=%HOURS%:%minutos%:%seconds% %AMPM%

if %HOURS% GEQ 01 (
	if %HOURS% LEQ 07 (
		set /a hora=%HOURS%+12-8
		set AMPM=PM
	)
)

if %HOURS%==08 (
	set hora=12
	set AMPM=AM
)

if %HOURS% GEQ 09 (
	if %HOURS% LEQ 20 (
		if %HOURS%==09 (
			set  hora=01
			set AMPM=AM
		) ELSE (
			if %HOURS%==20 (
				set /a hora=%HOURS%-8
				set AMPM=PM
			) ELSE (
				set /a hora=%HOURS%-8
				set AMPM=AM
			)
		)
	)
)

if %HOURS% GEQ 21 (
	if %HOURS% LEQ 24 (
		set /a hora=%HOURS%-8-12
		set AMPM=PM
	)
)

if %hora% LSS 10 (set hora=0%hora%) 

time %hora%:%minutos%:%seconds% %AMPM%