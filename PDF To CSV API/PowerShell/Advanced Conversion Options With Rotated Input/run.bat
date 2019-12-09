@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToCsvFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause