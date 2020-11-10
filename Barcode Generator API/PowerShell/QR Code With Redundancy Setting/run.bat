@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\GenerateBarcode.ps1"
echo Script finished with errorlevel=%errorlevel%

pause