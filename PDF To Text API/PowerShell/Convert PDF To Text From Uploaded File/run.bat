@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToTextFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause