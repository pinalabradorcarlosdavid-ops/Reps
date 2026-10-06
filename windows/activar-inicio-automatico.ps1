# Activa Claude Remote Control automaticamente al encender la computadora.
# Uso: abrir PowerShell y ejecutar
#   powershell -ExecutionPolicy Bypass -File .\activar-inicio-automatico.ps1

# 0. Carpeta de trabajo propia (en la carpeta personal la confianza no se guarda)
New-Item -ItemType Directory -Force -Path (Join-Path $HOME 'Claude') | Out-Null

# 1. Crear el lanzador en la carpeta de Inicio de Windows
$startup = [Environment]::GetFolderPath('Startup')
$launcher = Join-Path $startup 'Claude-Remote-Control.bat'
@'
@echo off
title Claude Remote Control - NO CERRAR
cd /d "%USERPROFILE%\Claude"
claude remote-control
'@ | Set-Content -Path $launcher -Encoding ASCII
Write-Host "Lanzador creado en: $launcher"

# 2. No suspender cuando este conectada a la corriente
powercfg /change standby-timeout-ac 0

# 3. No hacer nada al cerrar la tapa cuando este conectada a la corriente
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
powercfg /setactive SCHEME_CURRENT

Write-Host "Listo. La primera vez responde y para confiar en la carpeta. Luego reinicia para probarlo."
