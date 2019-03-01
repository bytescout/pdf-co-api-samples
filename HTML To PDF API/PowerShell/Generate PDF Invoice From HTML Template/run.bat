@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command "& .\GeneratePdfInvoiceFromHtmlTemplate.ps1"
echo Script finished with errorlevel=%errorlevel%

pause