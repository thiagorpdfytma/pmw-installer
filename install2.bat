@echo off
title Instalador PMW

echo ============================
echo Instalador iniciando...
echo ============================

:: CONFIG
set "PASTA=C:\PMW"
set "ZIP=%temp%\nerd.zip"
set "URL=https://raw.githubusercontent.com/thiagorpdfytma/pmw-installer/main/nerd.zip"

:: Criar pasta
echo Criando pasta...
mkdir "%PASTA%" >nul 2>&1

:: Baixar arquivo
echo Baixando arquivos...
powershell -Command "try { Invoke-WebRequest '%URL%' -OutFile '%ZIP%' } catch { exit 1 }"

if not exist "%ZIP%" (
    echo ERRO ao baixar arquivo!
    pause
    exit
)

:: Extrair
echo Extraindo...
powershell -Command "Expand-Archive '%ZIP%' '%PASTA%' -Force"

:: Verificar se extraiu
if not exist "%PASTA%" (
    echo ERRO na extracao!
    pause
    exit
)

:: Limpar
del "%ZIP%" >nul 2>&1

echo ============================
echo Instalacao concluida!
echo ============================

pause