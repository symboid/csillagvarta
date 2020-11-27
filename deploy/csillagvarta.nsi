
;!define _Config_x86
;!define _Config_Debug

!include ..\..\sdk\build\deploy\nsis\package.nsh

!insertmacro SetupComponentProps csillagvarta

!insertmacro Package "CsillagVarta"

!insertmacro ClearQtDeps
!insertmacro DeployModule csillagvarta\app\csillagvarta-app.exe
!insertmacro DeployModule sdk\arch\sdk-arch.dll
!insertmacro DeployModule sdk\controls\sdk-controls.dll
!insertmacro DeployModule sdk\dox\sdk-dox.dll
!insertmacro DeployModule sdk\network\sdk-network.dll
!insertmacro DeployModule sdk\hosting\sdk-hosting.dll
!insertmacro DeployModule astro\controls\astro-controls.dll
!insertmacro DeployModule astro\hora\astro-hora.dll
!insertmacro DeployModule astro\db\astro-db.dll
!insertmacro DeployFile   astro\db\sweph\ephe $INSTDIR sefstars.txt
!insertmacro DeployFile   astro\db\sweph\ephe $INSTDIR sepl_18.se1
!insertmacro DeployQtBasics
!insertmacro DeployQtDeps
!insertmacro IncludeVcRedist

!insertmacro RegAppPath csillagvarta-app.exe "${QtInstallDir}\bin"

!insertmacro StartMenuFolder ${COMPONENT_TITLE}
!insertmacro StartMenuLink "${COMPONENT_TITLE}" "$INSTDIR\csillagvarta-app.exe" "" ""
!insertmacro StartMenuLink "$(TextUninstall)" "$INSTDIR\${PackageUninstallerExe}" "" ""
!insertmacro DesktopLink ${COMPONENT_TITLE} "$INSTDIR\csillagvarta-app.exe" "" "$INSTDIR\csillagvarta-app.exe"

!insertmacro SetupComponentVersion
