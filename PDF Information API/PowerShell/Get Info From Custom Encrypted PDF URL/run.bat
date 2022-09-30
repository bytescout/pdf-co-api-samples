@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\GetPdfInfoFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause