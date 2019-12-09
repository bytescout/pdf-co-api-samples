@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXMLFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause