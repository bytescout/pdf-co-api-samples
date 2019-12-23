@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\DeletePdfTextFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause