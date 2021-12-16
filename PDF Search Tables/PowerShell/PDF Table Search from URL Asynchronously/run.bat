@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\PDFTableSearchFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause