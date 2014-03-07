@ECHO OFF
ECHO.

:: Read the Date format from the registry
CALL :ReadDateFormat

:: Use today if no second date was specified
IF "%~2"=="" (
	FOR %%A IN (%Date%) DO SET Date2=%%A
) ELSE (
	SET Date2=%2
)

:: Parse the first date
CALL :ParseDate 05/28/2011

:: Convert the parsed Gregorian date to Julian
CALL :JDate %GYear% %GMonth% %GDay%

:: Save the resulting Julian date
SET JDate1=%JDate%

:: Parse the second date
CALL :ParseDate %Date2%

:: Convert the parsed Gregorian date to Julian
CALL :JDate %GYear% %GMonth% %GDay%

:: Calculate the absolute value of the difference in days
IF %JDate% GTR %JDate1% (
	SET /A DateDiff = %JDate% - %JDate1%
) ELSE (
	SET /A DateDiff = %JDate1% - %JDate%
)

:: Format output for singular or plural
SET Days=days
IF %DateDiff% EQU 1 SET Days=day

:: Prefix value with a minus sign if negative
IF %JDate% GTR %JDate1% SET DateDiff=-%DateDiff%

:: Display the result
ECHO First date  : 05/28/2011
ECHO Second date : %Date2%
ECHO Difference  : %DateDiff% %Days%
set /A "_Result=%DateDiff%*864"
ECHO valor : %DateDiff%  %_Result%00000
C:\Progra~1\Oracle\VirtualBox\VBoxManage modifyvm winXP --biossystemtimeoffset %_Result%00000
C:\Progra~1\Oracle\VirtualBox\VBoxManage startvm winXP

:: Return the result in a variable named after this batch file
ENDLOCAL & SET %~n0=%DateDiff%
GOTO:EOF


::===================================::
::                                   ::
::   -   S u b r o u t i n e s   -   ::
::                                   ::
::===================================::


:JDate
:: Convert date to Julian
:: Arguments : YYYY MM DD
:: Returns   : Julian date
::
:: First strip leading zeroes; a logical error in this
:: routine was corrected with help from Alexander Shapiro
SET MM=%2
SET DD=%3
IF 1%MM% LSS 110 SET MM=%MM:~1%
IF 1%DD% LSS 110 SET DD=%DD:~1%
::
:: Algorithm based on Fliegel-Van Flandern
:: algorithm from the Astronomical Almanac,
:: provided by Doctor Fenton on the Math Forum
:: (http://mathforum.org/library/drmath/view/51907.html),
:: and converted to batch code by Ron Bakowski.
SET /A Month1 = ( %MM% - 14 ) / 12
SET /A Year1  = %1 + 4800
SET /A JDate  = 1461 * ( %Year1% + %Month1% ) / 4 + 367 * ( %MM% - 2 -12 * %Month1% ) / 12 - ( 3 * ( ( %Year1% + %Month1% + 100 ) / 100 ) ) / 4 + %DD% - 32075
FOR %%A IN (Month1 Year1) DO SET %%A=
GOTO:EOF 


:ParseDate
:: Parse (Gregorian) date depending on registry's date format settings
:: Argument : Gregorian date in local date format,
:: Requires : sDate (local date separator), iDate (local date format number)
:: Returns  : GYear (4-digit year), GMonth (2-digit month), GDay (2-digit day)
::
IF %iDate%==0 FOR /F "TOKENS=1-3 DELIMS=%sDate%" %%A IN ('ECHO.%1') DO (
	SET GYear=%%C
	SET GMonth=%%A
	SET GDay=%%B
)
IF %iDate%==1 FOR /F "TOKENS=1-3 DELIMS=%sDate%" %%A IN ('ECHO.%1') DO (
	SET GYear=%%C
	SET GMonth=%%B
	SET GDay=%%A
)
IF %iDate%==2 FOR /F "TOKENS=1-3 DELIMS=%sDate%" %%A IN ('ECHO.%1') DO (
	SET GYear=%%A
	SET GMonth=%%B
	SET GDay=%%C
)
GOTO:EOF


:ReadDateFormat
:: Read the Date format from the registry.
:: Arguments : none
:: Returns   : sDate (separator), iDate (date format number)
::
:: First, export registry settings to a temporary file:
START /W REGEDIT /E "%TEMP%.\_TEMP.REG" "HKEY_CURRENT_USER\Control Panel\International"
:: Now, read the exported data:
FOR /F "tokens=1* delims==" %%A IN ('TYPE "%TEMP%.\_TEMP.REG" ^| FIND /I "iDate"') DO SET iDate=%%B
FOR /F "tokens=1* delims==" %%A IN ('TYPE "%TEMP%.\_TEMP.REG" ^| FIND /I "sDate"') DO SET sDate=%%B
:: Remove the temporary file:
DEL "%TEMP%.\_TEMP.REG"
:: Remove quotes from the data read:
:: SET iDate=%iDate:"=%
FOR %%A IN (%iDate%) DO SET iDate=%%~A
:: SET sDate=%sDate:"=%
FOR %%A IN (%sDate%) DO SET sDate=%%~A
GOTO:EOF


:Syntax
ECHO DateDiff.bat,  Version 1.10 for Windows NT 4 / 2000 / XP / Server 2003 / Vista
ECHO Calculate the difference (in days) between two dates
ECHO.
ECHO Usage:  DATEDIFF  date  [ date ]
ECHO.
ECHO Where:  "date"  is a "normal" Gregorian date in the local computer's format;
ECHO                 if no second date is specified, today is assumed
ECHO.
ECHO Julian date conversion based on Fliegel-Van Flandern algorithms from
ECHO the Astronomical Almanac, provided by Doctor Fenton on the Math Forum
ECHO (http://mathforum.org/library/drmath/view/51907.html), and converted
ECHO to batch code by Ron Bakowski.
ECHO Bug found by and converted with help from Alexander Shapiro.
ECHO.
ECHO Written by Rob van der Woude
ECHO http://www.robvanderwoude.com

IF "%OS%"=="Windows_NT" ENDLOCAL