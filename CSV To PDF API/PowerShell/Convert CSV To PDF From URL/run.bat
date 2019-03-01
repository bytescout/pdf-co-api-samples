@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertCsvToPdfFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause