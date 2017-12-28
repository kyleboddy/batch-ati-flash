@echo off

REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd %~DP0

:Start

set /p id="Number of cards to be flashed (max 10): "
set /a numcards=(id-1)

echo.
echo "Calling atiflash for list of cards..."
atiflash.exe -i

echo.
echo "Starting ROM dump in 5 seconds..."
timeout /t 5

for /L %%A IN (0,1,%numcards%) DO (
	atiflash.exe -s %%A gpu%%A.rom
)

echo.
echo "Open up PolarisBIOSeditor and patch all gpu[x] files and save them to the same file, overwriting them."
timeout /t -1
echo.
echo "***Are you sure you want to continue? This will flash all %id% cards. ***"
echo.
timeout /t -1
echo.
echo "Last chance - hitting any key here begins the flashing operation...."
echo.
timeout /t -1
echo.

for /L %%A IN (0,1,%numcards%) DO (
	atiflash.exe -p %%A gpu%%A.rom
)

exit
