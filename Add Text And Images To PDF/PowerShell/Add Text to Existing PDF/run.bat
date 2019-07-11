@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\AddTextToExistingPDF.ps1"
echo Script finished with errorlevel=%errorlevel%

pause