@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToTiffFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause