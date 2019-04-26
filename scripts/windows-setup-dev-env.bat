:: Sets up various shortcuts and environment variables
:: Run as administrator

@ECHO OFF
SET START_MENU=%USERPROFILE%/Start Menu/Programs

MKDIR "%USERPROFILE%/code"
MKDIR "%USERPROFILE%/.local/bin"

:: clone github's confs.git and make links to essential scripts from it
:: github's public repo is always read-only without credentials so clone will work without problems!
%COMSPEC% /C "git clone https://github.com/kgaipal/confs.git "%USERPROFILE%/code/confs""

:: Note: to make soft links, use MKLINK instead of bash's ln otherwise
:: git-bash will copy target file to the link location instead [git bug #???]
MKLINK "%USERPROFILE%/.local/bin/grepk" "%USERPROFILE%/code/confs/scripts/grepk"
MKLINK "%USERPROFILE%/.local/bin/find-n-replace" "%USERPROFILE%/code/confs/scripts/find-n-replace"
MKLINK "%USERPROFILE%/.local/bin/em" "%USERPROFILE%/code/confs/scripts/em"
MKLINK "%USERPROFILE%/.local/bin/findk" "%USERPROFILE%/code/confs/scripts/findk"
MKLINK "%USERPROFILE%/.local/bin/util.inc" "%USERPROFILE%/code/confs/scripts/util.inc"
MKLINK "%USERPROFILE%/.local/bin/vs-make" "%USERPROFILE%/code/confs/scripts/vs-make.bat"
MKLINK "%USERPROFILE%/.gitconfig" "%USERPROFILE%/code/confs/misc/gitconfig"
PUSHD
CHDIR "%USERPROFILE%/code/confs/misc"
COPY "exclude-patterns.sample" "%USERPROFILE%/code/exclude-patterns.txt"
POPD

:: remove unwanted programs which came with vanilla installation
%COMSPEC% /C "powershell -ExecutionPolicy ByPass -File %USERPROFILE%/code/confs/scripts/windows10-remove-default-pacakges.ps1"

:: Registry editing
%COMSPEC% /C %USERPROFILE%/code/confs/scripts/caps_lock_to_control.reg
%COMSPEC% /C %USERPROFILE%/code/confs/scripts/cmd_env.reg
%COMSPEC% /C %USERPROFILE%/code/confs/scripts/remove_personal_one_drive_menu_explorer.reg

:: create shortcut for other scripts for start menu only
:: disabling thi now this since wee want to create a shortcut not symlinks!
rem MKLINK "%START_MENU%/vs-cmd" "%USERPROFILE%/code/confs/scripts/vs-dev-env.bat"

:: bashrc specific
(
ECHO # extensions to bashrc
ECHO BASHRC_EXTS=$HOME/code/confs/misc/
ECHO if [ -f $BASHRC_EXTS/bashrc_append ]; then
ECHO    . $BASHRC_EXTS/bashrc_append
ECHO fi
ECHO # alias definitions
ECHO if [ -f $BASHRC_EXTS/bash_aliases ]; then
ECHO   . $BASHRC_EXTS/bash_aliases
ECHO fi
) > "%USERPROFILE%/.bashrc"

ECHO Done setting up

:: Fix msys2 slowness on domain joined window 10 accounts
:: 1. Run the following commands to fix slow msys2
:: 2. Remove 'db' from /etc/nsswitch.conf
:: [http://bjg.io/guide/cygwin-ad/]
rem mkpasswd -l -c > /etc/passwd
rem mkgroup -l -c > /etc/group
