# run as:
# powershell -ExecutionPolicy ByPass -File ./windows10-remove-default-pacakges.ps1

# From:
# http://answers.microsoft.com/en-us/windows/forum/windows_10-windows_store/windows-10-removing-provisioned-apps/ad5105ee-bd5c-46ed-a6a7-57e3ccb419b9?auth=1
# $apps     = @("*messaging*", "*sway*", "*commsphone*", "*windowsphone*",
# "*xbox*", "*Zune*", "*OneNote*", "*Weather*", "*insider*",
# "*bingfinance*", "*bingnews*", "*bingsports*", "*bingweather*",
# "*solitaire*", "*officehub*", "*skypeapp*", "*getstarted*",
# "*3dbuilder*", "*flipboard*", "*fresh*", "*drawboard*", "*newyork*",
# "*twitter*", "*CandyCrushSodaSaga*", "*people*", "*bing*")

$apps = @(
    "*3dbuilder*",
    "*CandyCrush*",
    "*bing*",
    "*flipboard*",
    "*getstarted*",
    "*messaging*",
    "*officehub*"
    "*onenote*",
    "*people*",
    "*photos*",
    "*skypeapp*",
    "*solitaire*",
    "*soundrecorder*",
    "*twitter*",
    "*windowsalarms*",
    "*windowscamera*",
    "*windowscommunicationsapps*",
    "*windowsmaps*",
    "*xbox*",
    "*zune*",

    "NEVERMATCH"
)

# Remove the Apps we want to remove
foreach ($app in $apps) {
    Get-AppxPackage $app | Remove-AppxPackage
}