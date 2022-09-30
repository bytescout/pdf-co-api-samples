@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\SplitPdfFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause