@ECHO OFF
setlocal EnableDelayedExpansion

:: Auto elevation code taken from the following answer-
:: https://stackoverflow.com/a/28467343/14312937

:: net file to test privileges, 1>NUL redirects output, 2>NUL redirects errors
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto START ) else ( goto getPrivileges ) 

:getPrivileges
if '%1'=='ELEV' ( goto START )

set "batchPath=%~f0"
set "batchArgs=ELEV"

:: Add quotes to the batch path, if needed
set "script=%0"
set script=%script:"=%
IF '%0'=='!script!' ( GOTO PathQuotesDone )
    set "batchPath=""%batchPath%"""
:PathQuotesDone

:: Add quotes to the arguments, if needed
:ArgLoop
IF '%1'=='' ( GOTO EndArgLoop ) else ( GOTO AddArg )
    :AddArg
    set "arg=%1"
    set arg=%arg:"=%
    IF '%1'=='!arg!' ( GOTO NoQuotes )
        set "batchArgs=%batchArgs% "%1""
        GOTO QuotesDone
        :NoQuotes
        set "batchArgs=%batchArgs% %1"
    :QuotesDone
    shift
    GOTO ArgLoop
:EndArgLoop

:: Create and run the vb script to elevate the batch file
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "cmd", "/c ""!batchPath! !batchArgs!""", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs" 
exit /B

:START
:: Remove the elevation tag and set the correct working directory
IF '%1'=='ELEV' ( shift /1 )
cd /d %~dp0

:: Main script here

set "_onetitle=WinRAR Activator v0.01"

cls
mode 76, 30
title %_onetitle% by NaeemBolchhi
echo %_onetitle%
echo Created by NaeemBolchhi
echo https://naeembolchhi.github.io/WinRAR-Activator/
echo:

call :RARBIT
echo:
call :CLEANUP
echo:
echo ^- Starting WinRAR once to ensure file presence.
call :INITIATE
echo:
call :PAUSEWAIT
echo:
call :TERMINATE
echo:
call :SETKEY
echo:
echo ^- Registration complete. Starting WinRAR.
call :INITIATE
echo:
call :PAUSEWAIT
echo:
echo ^- This script will now end.
goto FINISH

:RARBIT
echo ^- Determining WinRAR location...
echo:
set "rarbit=unknown"
if exist "%SystemDrive%\Program Files (x86)\WinRAR\WinRAR.exe" set "rarbit=%SystemDrive%\Program Files (x86)\WinRAR"
if exist "%SystemDrive%\Program Files\WinRAR\WinRAR.exe" set "rarbit=%SystemDrive%\Program Files\WinRAR"
if "%rarbit%" EQU "unknown" (
  echo ^- WinRAR was not found in the default directories.
  echo:
  pause
  goto FINISH
) else (
  echo ^- WinRAR was found in "%rarbit%".
)
exit /b

:CLEANUP
echo ^- Cleaning up any existing registration keys.
if exist "%rarbit%\rarreg.key" (
  del /f /q "%rarbit%\rarreg.key" 1>nul
)
exit /b

:INITIATE
start /b "" "%rarbit%\WinRAR.exe"
exit /b

:TERMINATE
echo ^- Closing all open WinRAR processes.
taskkill /f /im WinRAR.exe /t
exit /b

:PAUSEWAIT
echo ^- Please wait a moment.
timeout /t 3 /nobreak > nul
exit /b

:SETKEY
echo ^- Registering your copy of WinRAR.
(
  echo RAR registration data
  echo Hououin Kyouma
  echo El Psy Congroo
  echo UID=c881245b7b1a78985cb0
  echo 64122122505cb05c44e75618ab5ea84c86e876e620d42d566d4453
  echo 18f59893063b0c337398603ef609acfb0eac3505bc19e61df2b7f5
  echo bba0aeef9172868794c0d6b2314c038d105f9b3ba638ec8a82305b
  echo a209c087680d071cbbdbb10a9652f8c2b06091a5243fbbc24b381d
  echo 4cb3b58c52c3d7d99b828c76f88937dd4d94058fb3038d105f9b3b
  echo a638ec8aa57606488b324a1e71be06e54787b797df438679604ee6
  echo 92b1f552734e6580bee03078379b0cdddee16bb6f4a53644961125
  echo ------------------------------------------------------
) > "%rarbit%\rarreg.key"
exit /b

:FINISH
timeout /t 3 /nobreak > nul
exit
