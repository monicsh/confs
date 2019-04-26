# Reset cluster

# execute in admin in powershell
& "$ENV:ProgramFiles\Microsoft SDKs\Service Fabric\ClusterSetup\DevClusterSetup.ps1" -PathToClusterDataRoot "D:\SfDevCluster\Data" -PathToClusterLogRoot "D:\SfDevCluster\Log" -CreateOneNodeCluster

# remove C: after previous setup
$SFCLUSTER_C = "C:\SfDevCluster"
if (Test-Path -Path $SFCLUSTER_C ) {
   & Remove-Item -Path $SFCLUSTER_C -Recurse
}

& Write-Host "Done"
