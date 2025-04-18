

# نصب آنتی ویروس
$antivirusInstaller = "C:\software\antivirus\Padvish.exe"  
if (Test-Path $antivirusInstaller) {
    Start-Process -FilePath $antivirusInstaller -ArgumentList "/silent" -Wait
}

# حذف خودش بعد از اجرا (اختیاری)
Remove-Item -Path $MyInvocation.MyCommand.Path -Force
