
!include ..\..\build\deploy\nsis\api.nsh

!insertmacro ComponentApiBegin csillagvarta
!insertmacro ExeFolder app
!insertmacro FileApi include\csillagvarta component.h
!insertmacro FileApi assets\csillagvarta component.ico
!insertmacro FileApi deploy csillagvarta.nsi
