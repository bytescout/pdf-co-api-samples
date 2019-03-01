@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\MakeSearchablePdfFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause