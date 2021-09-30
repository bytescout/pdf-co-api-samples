@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertWebPageToPdfFromLink.ps1"
echo Script finished with errorlevel=%errorlevel%

pause