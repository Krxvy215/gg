@echo off
cd C:\Windows\System32\Tasks
DevManView.exe /uninstall "SWD\MS*" /use_wildcard

start /wait /b  DeviceCleanup.exe * -s
DriveCleanup.exe 
del "C:\Users\%username%\AppData\Local\Temp.*"
mkdir "C:\Windows\temp"
mkdir "C:\Users\%username%\AppData\Local\Temp"
set try=1


:retry
set /A try=%try%+1
for %%p in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%p:\nul DevManView.exe /uninstall "%%p:\" && echo did %%p drive
@echo on
DevManView.exe /uninstall "C:\"
DevManView.exe /uninstall "Disk drive*" /use_wildcard
DevManView.exe /uninstall "Disk"
DevManView.exe /uninstall "disk"
DevManView.exe /uninstall "Disk&*" /use_wildcard
DevManView.exe /uninstall "SWD\WPDBUSENUM*" /use_wildcard
DevManView.exe /uninstall "USBSTOR*" /use_wildcard
DevManView.exe /uninstall "SCSI\Disk*" /use_wildcard
DevManView.exe /uninstall "STORAGE*" /use_wildcard
DevManView.exe /uninstall "Motherboard*" /use_wildcard
DevManView.exe /uninstall "Volume*" /use_wildcard
DevManView.exe /uninstall "Microsoft*" /use_wildcard
DevManView.exe /uninstall "System*" /use_wildcard
DevManView.exe /uninstall "ACPI\*" /use_wildcard
DevManView.exe /uninstall "Remote*" /use_wildcard
DevManView.exe /uninstall "Standard*" /use_wildcard



TASKKILL /F /IM WmiPrvSE.exe
TASKKILL /F /IM WmiPrvSE.exe

@echo off

PING localhost -n 15 >NUL


del output.txt /f1>nul 2>nul
wmic diskdrive get serialnumber >output.txt
for /f %%i in ("output.txt") do set size=%%~zi
if %size% gtr 6 goto retry

del output.txt /f1>nul 2>nul
devcon rescan
:internettest
cls
if errorlevel==1 goto internettest
cls
echo scanning for hardware changes
#devcon rescan
net stop winmgmt /y
net start winmgmt /y
sc stop winmgmt
sc start winmgmt
ipconfig /flushdns
exit