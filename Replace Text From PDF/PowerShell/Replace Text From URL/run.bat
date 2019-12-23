@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\replaceStringFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause