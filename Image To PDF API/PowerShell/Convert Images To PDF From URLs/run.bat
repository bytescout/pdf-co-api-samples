@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertImagesToPdfFromUrls.ps1"
echo Script finished with errorlevel=%errorlevel%

pause