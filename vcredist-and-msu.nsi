Unicode True
!include StrContains.nsh

# 名称
Name "vcredist-and-msu"

# 文件名称
Outfile "vcredist-and-msu.exe"

# 安装目录
InstallDir "C:\Install"
AutoCloseWindow true

# default section
Section

CreateDirectory $INSTDIR\packages
# define the output path for this file
SetOutPath $INSTDIR

# 安装文件
File /r "packages"
File "platform_info.py"
File "postgresql-14.1-1-windows-x64.exe"
File "python-3.8.10-amd64.exe"
File "python-package.bat"
File "qt_simple_window.py"
File "VC_redist.x64.exe"
File "Windows6.1-KB3063858-x64.msu"
File "wait-finish.py"
File "fin.bat"

SectionEnd

Section "Windows更新" SEC1
  
clearerrors
nsExec::ExecToStack 'cmd /Q /C "wmic.exe qfe get hotfixid | findstr.exe "^KB3063858""'
Pop $0 ; return value (it always 0 even if an error occured)
Pop $1 ; command output
detailprint $0
detailprint $1

Push $1
Push "KB3063858"
Call StrContains
Pop $0
StrCmp $0 "" notfound
  Goto done
notfound:
    ExecWait "wusa.exe $INSTDIR\Windows6.1-KB3063858-x64.msu /quiet /norestart"
    MessageBox MB_YESNO|MB_ICONINFORMATION "需要重启以继续安装。" IDNO +2
    Reboot
done:

SectionEnd

Section "VC_redist" SEC2
  
clearerrors
ExecWait "$INSTDIR\VC_redist.x64.exe /install /passive /norestart"
SectionEnd


Section "python安装" SEC3

clearerrors
nsExec::ExecToStack 'cmd /Q /C "python "$INSTDIR\platform_info.py"'
Pop $0 ; return value (it always 0 even if an error occured)
Pop $1 ; command output
; 显示命令输出
; DetailPrint "$1"

Push $1
Push "Python 3"
Call StrContains
Pop $0
StrCmp $0 "" notfound
  Goto done
notfound:
  ExecWait "$INSTDIR\python-3.8.10-amd64.exe /passive InstallAllUsers=1 PrependPath=1 Include_test=1 Shortcuts=0"

done:

SectionEnd

Section "python-package" SEC5
  ExecWait "$INSTDIR\python-package.bat"
SectionEnd

Section "launch" SEC6
  Exec "$INSTDIR\fin.bat"
SectionEnd
