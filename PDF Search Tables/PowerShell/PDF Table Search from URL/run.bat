@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\GetPdfTableSearchFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause