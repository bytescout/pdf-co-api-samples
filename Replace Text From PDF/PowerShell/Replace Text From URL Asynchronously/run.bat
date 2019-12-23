@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\replaceStringFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause