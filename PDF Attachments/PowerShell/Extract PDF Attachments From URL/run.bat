@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\program.ps1"
echo Script finished with errorlevel=%errorlevel%

pause