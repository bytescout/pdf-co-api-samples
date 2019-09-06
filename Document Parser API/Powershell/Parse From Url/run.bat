@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ParseFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause