@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\MergePdfDocumentsFromUploadedFiles.ps1"
echo Script finished with errorlevel=%errorlevel%

pause