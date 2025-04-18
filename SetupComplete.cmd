@echo off
echo Starting post-Sysprep configuration...
powershell.exe -ExecutionPolicy Bypass -File "C:\Windows\Setup\Scripts\PostSysprep.ps1"
echo Configuration completed.