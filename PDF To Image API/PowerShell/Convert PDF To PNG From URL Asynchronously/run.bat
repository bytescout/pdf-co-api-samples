@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToPngFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause