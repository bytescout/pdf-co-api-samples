@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\RotatePdfFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause