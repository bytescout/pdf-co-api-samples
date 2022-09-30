@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\MergePdfDocumentsFromUrlsAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause