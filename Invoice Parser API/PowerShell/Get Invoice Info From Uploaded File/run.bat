@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\GetInvoiceInfoFromUploadedFile.ps1"
echo Script finished with errorlevel=%errorlevel%

pause