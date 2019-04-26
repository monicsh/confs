::
:: Kshitij Gaipal
::
:: Sets the custom prompt, path, etc for cmd.exe and also defines some aliases like bash
:: http://stackoverflow.com/questions/20530996/aliases-in-windows-command-prompt#20531778

:: Should be included this way so that each instance of cmd.exe loads
:: [HKEY_CURRENT_USER\Software\Microsoft\Command Processor]
:: "AutoRun"="%USERPROFILE%\\code\\confs\\scripts\\env.cmd"


@ECHO OFF

:: Add "~/.local/bin" and some usefull unix tools like grep, find, etc available
set PATH="%USERPROFILE%/.local/bin;C:/msys64/usr/bin;C:/msys64/mingw64/bin";%PATH%

:: Set prompt
set PROMPT=[$P]$_$$ 

:: Commands
DOSKEY b=CHDIR ../
DOSKEY ll=DIR /N
