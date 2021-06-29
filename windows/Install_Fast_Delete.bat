@echo off

:: This is an automation of the way in https://spblog.net/post/2020/06/10/how-to-effectively-delete-node-modules-on-windows

echo Get Admin Authorization...
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
	goto UACPrompt
) else (
	goto gotAdmin
)
:UACPrompt
	echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
	"%temp%\getadmin.vbs"
	exit /B
:gotAdmin
	if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
	pushd "%CD%"
	CD /D "%~dp0"
echo Done

echo Installing rimraf to global...
call npm install rimraf -g
echo Done

echo Create bat file and copy to System folder...
set scriptName=%SystemRoot%\fast-del.bat
echo @ECHO OFF > %scriptName%
echo SET FOLDER=%%1 >> %scriptName%
echo IF [%%1]==[] ( >> %scriptName%
echo 	ECHO 删除文件夹: "%%CD%%"? >> %scriptName%
echo 	PAUSE >> %scriptName%
echo 	SET FOLDER="%%CD%%" >> %scriptName%
echo 	CD / >> %scriptName%
echo ) >> %scriptName%
echo ECHO 正在删除 %%FOLDER%% >> %scriptName%
echo rimraf %%FOLDER%% >> %scriptName%
echo Done

echo Add command to right click menu...
set regName=Add_Fast_Delete.reg
echo Windows Registry Editor Version 5.00 > %regName%
echo  >> %regName%
echo ;添加右键菜单 >> %regName%
echo [HKEY_CLASSES_ROOT\Directory\shell\快速删除\command] >> %regName%
echo ""="cmd /c \"cd /d %%1 ^&^& fast-del.bat\""  >> %regName%
reg import "%regName%"
del %regName%

echo Done
PAUSE
