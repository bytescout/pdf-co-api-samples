@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertWebPageToPdfFromLinkAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause