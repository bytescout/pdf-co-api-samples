@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertPdfToXmlFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause