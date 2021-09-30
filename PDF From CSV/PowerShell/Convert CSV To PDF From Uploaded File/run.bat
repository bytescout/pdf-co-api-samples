@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\ConvertCsvToPdfFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause