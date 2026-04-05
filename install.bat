::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcDeMJVOGJ6UMzOnv7tarrU4cWN4LfYLL5oaPMtM10hXYe5M/0jRAkdts
::fBE1pAF6MU+EWHreyHcjLQlHcDeMJVOGJ6UMzOnv7tarrU4cWN4LfYLL5oaPMtM10hXYfJg+wntWlIUODQ84
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFAFRVQiOPVeeA6YX/Ofr07KS+loRGeoqfp6Ol+Teca4a6UqE
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF65
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBNQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFChaVTy+HXuqIrQI6dTX4OmGrnEpUe8vRL3ayIeoGLAv2XHBVLtt+lNsqu5MJTVrSjOHSz16rHZH1g==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
title Instalador

echo Baixando arquivos...

:: Pasta destino
set "PASTA=C:\PMW"
set "ZIP=%temp%\arquivo.zip"
set "URL=https://SEU-LINK-AQUI/nerd.zip"

:: Criar pasta
mkdir "%PASTA%" >nul 2>&1

:: Baixar arquivo
powershell -Command "Invoke-WebRequest '%URL%' -OutFile '%ZIP%'"

echo Instalando...

:: Extrair
powershell -Command "Expand-Archive '%ZIP%' '%PASTA%' -Force"

:: Limpar
del "%ZIP%"

echo.
echo Instalacao concluida!
pause