@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertCsvToPdfFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause