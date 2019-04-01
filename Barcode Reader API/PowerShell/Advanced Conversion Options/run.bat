@echo off

echo (Get-Location).Path

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ReadBarcodeFromURL.ps1"
echo Script finished with errorlevel=%errorlevel%

pause