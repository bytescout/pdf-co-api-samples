@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXmlFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause