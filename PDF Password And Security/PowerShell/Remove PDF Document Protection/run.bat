@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\RemovePDFDocumentProtection.ps1"
echo Script finished with errorlevel=%errorlevel%

pause