@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\AddImagesToExistingPDF.ps1"
echo Script finished with errorlevel=%errorlevel%

pause