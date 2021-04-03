
!include ..\..\build\deploy\nsis\api.nsh

!insertmacro ComponentApiBegin csillagvarta
!insertmacro ExeFolder app
!insertmacro FileApi assets\csillagvarta component.h
;!insertmacro FileApi assets\csillagvarta component.ico
!insertmacro FileApi assets csillagvarta.nsi
