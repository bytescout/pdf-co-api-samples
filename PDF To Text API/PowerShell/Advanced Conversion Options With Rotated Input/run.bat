@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToTxtFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause