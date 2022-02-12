Unicode True
!include StrContains.nsh

# 名称
Name "box-test"

# 文件名称
Outfile "box-test.exe"

# 安装目录
InstallDir "C:\Install"
; AutoCloseWindow true

Section "VCruntime-and-boxStatus"
SetOutPath $INSTDIR
File "VC_redist.x64.exe"
File "build\box_op.exe"
File "build\get_result.exe"

clearerrors

ExecWait "$INSTDIR\VC_redist.x64.exe /install /passive /norestart"
SetOutPath "$INSTDIR\build"
Exec "$INSTDIR\build\power_keep.exe"
clearerrors
ExecWait "$INSTDIR\build\box_op.exe get"
nsExec::ExecToStack 'cmd /Q /C "$INSTDIR\build\get_result.exe"'
Pop $0 ; return value (it always 0 even if an error occured)
Pop $1 ; command output
detailprint $0
detailprint $1

Push $1
Push "11"
Call StrContains
Pop $0
StrCmp $0 "" notfound
Goto found

found:
  MessageBox MB_YESNO|MB_ICONINFORMATION "需要重启以解除文件保护。" IDNO +3
  ExecWait "$INSTDIR\build\box_op.exe set disabled"
  Reboot
notfound:

SectionEnd


# default section
Section

MessageBox MessageBox MB_OK "安装过程"

SectionEnd

Section "re-enable box"
SetOutPath "$INSTDIR\build"

clearerrors
nsExec::ExecToStack '$INSTDIR\build\get_result.exe'
Pop $0 ; return value (it always 0 even if an error occured)
Pop $1 ; command output
detailprint $0
detailprint $1

Push $1
Push "00"
Call StrContains
Pop $0
StrCmp $0 "" notfound
  Goto found
found:
  MessageBox MB_YESNO|MB_ICONINFORMATION "安装完成。需要重启以添加文件保护。" IDNO +3
  ExecWait "$INSTDIR\build\box_op.exe set enabled"
  Reboot
notfound:

SectionEnd
