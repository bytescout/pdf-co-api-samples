@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToCsvFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause