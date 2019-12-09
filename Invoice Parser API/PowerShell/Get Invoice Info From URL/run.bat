@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\GetInvoiceInfoFromUrl.ps1"
echo Script finished with errorlevel=%errorlevel%

pause