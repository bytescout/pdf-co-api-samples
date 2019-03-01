@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToTiffFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause