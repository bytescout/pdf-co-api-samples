@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXlsFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause