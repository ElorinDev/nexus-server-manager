@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-tools\Criar-Pacote.ps1" %*
if errorlevel 1 pause
