
!include ..\..\build\deploy\nsis\api.nsh

!insertmacro ComponentApiBegin csillagvarta
!insertmacro ExeFolder app
!insertmacro FileApi . component.h
!insertmacro FileApi . component.ico
!insertmacro FileApi deploy csillagvarta.nsi
