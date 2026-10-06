# Quita el inicio automatico de Claude Remote Control.
$launcher = Join-Path ([Environment]::GetFolderPath('Startup')) 'Claude-Remote-Control.bat'
if (Test-Path $launcher) {
    Remove-Item $launcher
    Write-Host "Inicio automatico desactivado."
} else {
    Write-Host "No estaba activado."
}
