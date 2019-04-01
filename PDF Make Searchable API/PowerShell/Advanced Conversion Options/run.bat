@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\MakeSearchablePdfFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause