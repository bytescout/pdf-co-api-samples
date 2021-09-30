@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXlsxFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause