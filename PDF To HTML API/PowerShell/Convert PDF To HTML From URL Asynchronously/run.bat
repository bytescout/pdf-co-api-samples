@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToHtmlFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause