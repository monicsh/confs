::
:: Kshitij Gaipal
::
:: Exec's msbuild from current shell.

:: VS 2015
rem @CALL "C:/Program Files (x86)/Microsoft Visual Studio 14.0/Common7/Tools/VsDevCmd.bat"

:: VS 2017
@CALL "C:/Program Files (x86)/./Microsoft Visual Studio/2017/Enterprise/Common7/Tools/VsDevCmd.bat"
CALL "msbuild" "/v:minimal" %*
