@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToJpegFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause