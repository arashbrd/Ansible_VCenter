

$antivirusInstaller = "C:\software\antivirus\Padvish.exe"  
if (Test-Path $antivirusInstaller) {
    Start-Process -FilePath $antivirusInstaller -ArgumentList "/silent" -Wait
}

Remove-Item -Path $MyInvocation.MyCommand.Path -Force
