@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\InvoiceParser.ps1"
echo Script finished with errorlevel=%errorlevel%

pause