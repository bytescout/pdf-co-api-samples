@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertImagesToPdfFromUrlsAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause