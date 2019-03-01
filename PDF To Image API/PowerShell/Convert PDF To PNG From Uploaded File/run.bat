@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToPngFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause