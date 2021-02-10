@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\MergeAnyDocumentsFromUrls.ps1"
echo Script finished with errorlevel=%errorlevel%

pause