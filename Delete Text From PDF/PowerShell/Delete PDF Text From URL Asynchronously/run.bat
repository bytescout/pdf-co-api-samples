@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\DeletePdfTextFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause