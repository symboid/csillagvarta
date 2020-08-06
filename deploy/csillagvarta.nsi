
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
!insertmacro DeployModule sdk\hosting\sdk-hosting.dll
!insertmacro DeployModule astro\uicontrols-qt\astro-uicontrols-qt.dll
!insertmacro DeployModule astro\sweph\astro-sweph.dll
!insertmacro DeployModule astro\db\astro-db.dll
!insertmacro DeployFile   astro\sweph\src $INSTDIR sefstars.txt
!insertmacro DeployFile   astro\sweph\src $INSTDIR sepl_18.se1
!insertmacro DeployQtBasics
!insertmacro DeployQtDeps
!insertmacro IncludeVcRedist

!insertmacro RegAppPath csillagvarta-app.exe "${QtInstallDir}\bin"

!insertmacro StartMenuFolder ${COMPONENT_TITLE}
!insertmacro StartMenuLink "${COMPONENT_TITLE}" "$INSTDIR\csillagvarta-app.exe" "" ""
!insertmacro StartMenuLink "$(TextUninstall)" "$INSTDIR\${PackageUninstallerExe}" "" ""
!insertmacro DesktopLink ${COMPONENT_TITLE} "$INSTDIR\csillagvarta-app.exe" "" "$INSTDIR\csillagvarta-app.exe"

!insertmacro SetupComponentVersion
