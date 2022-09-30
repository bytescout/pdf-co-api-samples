@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertDocToPdfFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause