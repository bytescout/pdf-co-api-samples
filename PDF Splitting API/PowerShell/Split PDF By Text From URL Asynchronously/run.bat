@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\SplitPdfFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause