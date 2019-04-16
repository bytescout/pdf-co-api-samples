@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\GetPdfTextSearchFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause