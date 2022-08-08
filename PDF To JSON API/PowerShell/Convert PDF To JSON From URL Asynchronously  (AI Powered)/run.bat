@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToJsonFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause