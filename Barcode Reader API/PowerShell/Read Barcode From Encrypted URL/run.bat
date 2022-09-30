@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ReadBarcodeFromURL.ps1"
echo Script finished with errorlevel=%errorlevel%

pause