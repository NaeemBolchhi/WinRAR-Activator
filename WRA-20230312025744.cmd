@ECHO OFF
setlocal EnableDelayedExpansion

:: Auto elevation code taken from the following answer-
:: https://stackoverflow.com/a/28467343/14312937

::net file to test privileges, 1>NUL redirects output, 2>NUL redirects errors
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto START ) else ( goto getPrivileges ) 

:getPrivileges
if '%1'=='ELEV' ( goto START )

set "batchPath=%~f0"
set "batchArgs=ELEV"

::Add quotes to the batch path, if needed
set "script=%0"
set script=%script:"=%
IF '%0'=='!script!' ( GOTO PathQuotesDone )
    set "batchPath=""%batchPath%"""
:PathQuotesDone

::Add quotes to the arguments, if needed
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

::Create and run the vb script to elevate the batch file
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "cmd", "/c ""!batchPath! !batchArgs!""", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs" 
exit /B

:START
::Remove the elevation tag and set the correct working directory
IF '%1'=='ELEV' ( shift /1 )
cd /d %~dp0

::Main script here

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
call :FINISH

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
  call :FINISH
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
  echo WinRAR
  echo Unlimited Company License
  echo UID=4b914fb772c8376bf571
  echo 6412212250f5711ad072cf351cfa39e2851192daf8a362681bbb1d
  echo cd48da1d14d995f0bbf960fce6cb5ffde62890079861be57638717
  echo 7131ced835ed65cc743d9777f2ea71a8e32c7e593cf66794343565
  echo b41bcf56929486b8bcdac33d50ecf773996052598f1f556defffbd
  echo 982fbe71e93df6b6346c37a3890f3c7edc65d7f5455470d13d1190
  echo 6e6fb824bcf25f155547b5fc41901ad58c0992f570be1cf5608ba9
  echo aef69d48c864bcd72d15163897773d314187f6a9af350808719796
  echo ----------------------------------------------------------------------------------------------------------
) > "%rarbit%\rarreg.key"
exit /b

:FINISH
timeout /t 3 /nobreak > nul
exit