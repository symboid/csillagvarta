
;!define _Config_x86
;!define _Config_Debug

!include ..\..\sdk\build\deploy\nsis\package.nsh

!insertmacro SetupComponentProps csillagvarta

!insertmacro Package "CsillagVarta"

!insertmacro ClearQtDeps
!insertmacro DeployModule csillagvarta\app\csillagvarta-app.exe
!insertmacro DeployModule sdk\arch\sdk-arch.dll
!insertmacro DeployModule sdk\uicontrols-qt\sdk-uicontrols-qt.dll
!insertmacro DeployModule sdk\dox-qt\sdk-dox-qt.dll
!insertmacro DeployModule sdk\network-qt\sdk-network-qt.dll
!insertmacro DeployModule astro\uicontrols-qt\astro-uicontrols-qt.dll
!insertmacro DeployModule astro\sweph\astro-sweph.dll
!insertmacro DeployFile   astro\sweph\src $INSTDIR sefstars.txt
!insertmacro DeployFile   astro\sweph\src $INSTDIR sepl_18.se1
!insertmacro DeployQtBasics
!insertmacro DeployQtDeps

;!insertmacro StartMenuFolder ${COMPONENT_TITLE}
;!insertmacro StartMenuBootLink ${COMPONENT_TITLE} "kirkoszkop" "$INSTDIR\kirkoszkop.exe"
;!insertmacro StartMenuLink "$(TextUninstall)" "$INSTDIR\${PackageUninstallerExe}" "" ""
;!insertmacro DesktopBootLink ${COMPONENT_TITLE} "kirkoszkop" "$INSTDIR\kirkoszkop.exe"

;!insertmacro SetupComponentVersion
