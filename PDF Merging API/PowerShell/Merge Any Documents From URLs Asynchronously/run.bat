@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\MergeAnyDocumentsFromUrlsAsynchronously.ps1"
echo Script finished with errorlevel=%errorlevel%

pause