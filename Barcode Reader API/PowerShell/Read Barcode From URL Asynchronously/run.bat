@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ReadBarcodeFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause