@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToJsonFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause