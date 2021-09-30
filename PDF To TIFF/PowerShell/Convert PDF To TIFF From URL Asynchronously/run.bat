@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToTiffFromUrlAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause