@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\MergePdfDocumentsFromUrls.ps1"
echo Script finished with errorlevel=%errorlevel%

pause