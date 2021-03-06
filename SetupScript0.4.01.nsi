;Product Info
Name "Kindle Auto Ebook Converter" ;Define your own software name here
!define PRODUCT "Kindle Auto Ebook Converter" ;Define your own software name here
!define VERSION "0.4.11" ;Define your own software version here

CRCCheck On
; Script create for version 2.0rc1/final (from 12.jan.04) with GUI NSIS (c) by Dirk Paehl. Thank you for use my program

 !include "MUI.nsh"

SetCompressor lzma
 
;--------------------------------
;Configuration
 
   OutFile "Auto_Kindle_v${VERSION}.exe"
BRANDINGTEXT "Auto Kindle"

  ;Folder selection page
   InstallDir "$PROGRAMFILES\${PRODUCT}"

;Remember install folder
InstallDirRegKey HKCU "Software\${PRODUCT}" ""

;--------------------------------
;Pages
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES

 !define MUI_ABORTWARNING

 
;--------------------------------
 ;Language
 
  !insertmacro MUI_LANGUAGE "English"
;--------------------------------

     
Section "section_1" section_1
SetOutPath "$INSTDIR"
FILE /r "C:\kindle\*.*"
;SetOutPath "$INSTDIR"
;FILE "C:\kindle\Auto Kindle.exe"
SectionEnd

Section Shortcuts
CreateDirectory "$SMPROGRAMS\Auto Kindle Ebook Converter"
  WriteIniStr "$SMPROGRAMS\Auto Kindle Ebook Converter\Kindle Auto Ebook Converter.url" "InternetShortcut" "URL" "http://forum.deadmessengers.net"
  ;CreateShortCut "$SMPROGRAMS\Auto Kindle Ebook Converter\Auto Kindle Ebook Converter Website.lnk" "$INSTDIR\Kindle Auto Ebook Converter.url" "" "$INSTDIR\Kindle Auto Ebook Converter.url" 0
  CreateShortCut "$SMPROGRAMS\Auto Kindle Ebook Converter\Auto Kindle Ebook Converter.lnk" "$INSTDIR\Auto Kindle.exe" "" "$INSTDIR\Auto Kindle.exe" 0
SectionEnd

Section Uninstaller
  CreateShortCut "$SMPROGRAMS\Auto Kindle Ebook Converter\Uninstall.lnk" "$INSTDIR\uninst.exe" "" "$INSTDIR\uninst.exe" 0
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Kindle Auto Ebook Converter" "DisplayName" "${PRODUCT} ${VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Kindle Auto Ebook Converter" "DisplayVersion" "${VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Kindle Auto Ebook Converter" "URLInfoAbout" "http://forum.deadmessengers.net"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Kindle Auto Ebook Converter" "Publisher" "The Messenger"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Kindle Auto Ebook Converter" "UninstallString" "$INSTDIR\Uninst.exe"
  WriteRegStr HKCU "Software\${PRODUCT}" "" $INSTDIR
  WriteUninstaller "$INSTDIR\Uninst.exe"
 
 
SectionEnd
 
 
Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer.."
FunctionEnd
  
Function un.onInit 
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd
 
Section "Uninstall"
  Delete "$INSTDIR\app\*.*"
  Delete "$INSTDIR\Temp\*.*"
  Delete "$INSTDIR\lib\*.*"
  Delete "$INSTDIR\*.*"
  Delete "$SMPROGRAMS\Auto Kindle Ebook Converter\*.*"
  RmDir "$SMPROGRAMS\Auto Kindle Ebook Converter"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Kindle Auto Ebook Converter"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Kindle Auto Ebook Converter"
  RmDir "$INSTDIR\Temp"
  RmDir "$INSTDIR\app"
  RmDir "$INSTDIR\lib"
  RmDir "$INSTDIR"
             
SectionEnd
               
   
Function .onInstSuccess
   ;ExecShell open "$INSTDIR\Auto Kindle.exe"
FunctionEnd
;eof
