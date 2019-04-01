@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToTextFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause