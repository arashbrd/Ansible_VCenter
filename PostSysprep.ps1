# تنظیم AllowAdministratorLockout = 0
$secpolTemplate = @"
[Unicode]
Unicode=yes
[Version]
signature="`$CHICAGO`$"
Revision=1
[System Access]
AllowAdministratorLockout = 0
"@

$tempFile = "$env:TEMP\secpol.inf"
$secpolTemplate | Out-File -FilePath $tempFile -Encoding unicode

# اعمال تنظیمات امنیتی
secedit /configure /db "$env:windir\security\new.sdb" /cfg $tempFile /areas SECURITYPOLICY

# حذف فایل موقت
Remove-Item $tempFile -Force

# فعال کردن WinRM (اختیاری)
Enable-PSRemoting -Force
winrm quickconfig -quiet


# ایجاد قانون فایروال برای اتصال WinRM از IPهای خاص
New-NetFirewallRule -Name "AllowWinRM_192.168.230.x" -DisplayName "Allow WinRM from 192.168.230.x" -Enabled True -Protocol TCP -Direction Inbound -Action Allow -LocalPort 5985 -RemoteAddress 192.168.230.0/24
New-NetFirewallRule -Name "AllowWinRM_192.168.110.x" -DisplayName "Allow WinRM from 192.168.110.x" -Enabled True -Protocol TCP -Direction Inbound -Action Allow -LocalPort 5985 -RemoteAddress 192.168.110.0/24
New-NetFirewallRule -Name "AllowWinRM_192.168.150.x" -DisplayName "Allow WinRM from 192.168.150.x" -Enabled True -Protocol TCP -Direction Inbound -Action Allow -LocalPort 5985 -RemoteAddress 192.168.150.0/24

# تنظیم WinRM برای استفاده از NTLM
winrm set winrm/config/client '@{AllowUnencrypted="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="false"; Kerberos="true"; Negotiate="true"}'

# فعال کردن RemoteDesktop 
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# ایجاد قوانین فایروال برای WinRM و Remote Desktop

New-NetFirewallRule -Name "AllowRDP_192.168.230.x" -DisplayName "Allow RDP from 192.168.230.x" -Enabled True -Protocol TCP -Direction Inbound -Action Allow -LocalPort 3389 -RemoteAddress 192.168.230.0/24
New-NetFirewallRule -Name "AllowRDP_192.168.110.x" -DisplayName "Allow RDP from 192.168.110.x" -Enabled True -Protocol TCP -Direction Inbound -Action Allow -LocalPort 3389 -RemoteAddress 192.168.110.0/24
New-NetFirewallRule -Name "AllowRDP_192.168.150.x" -DisplayName "Allow RDP from 192.168.150.x" -Enabled True -Protocol TCP -Direction Inbound -Action Allow -LocalPort 3389 -RemoteAddress 192.168.150.0/24


# نصب VMware Tools اگر وجود داشت
$vmwareToolsPath = "C:\software\vmware-tools\setup64.exe"
if (Test-Path $vmwareToolsPath) {
    Start-Process -FilePath $vmwareToolsPath -ArgumentList "/S /v""/qn REBOOT=R""" -Wait
}

