@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\PDFTextSearchFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause