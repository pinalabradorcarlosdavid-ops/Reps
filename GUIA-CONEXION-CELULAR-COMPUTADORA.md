# Guía: controlar tu computadora desde el celular con Claude

Con esta guía vas a poder darle órdenes a Claude desde tu celular. Claude va a hacer el trabajo en tu computadora (por ahora la ASUS con Windows y más adelante la Mac). Cuando necesite un permiso, te va a llegar una notificación al celular para que lo apruebes.

La conexión se activa **una vez desde la computadora**. Después todo se maneja desde el celular.

---

## Parte 1: preparar la computadora Windows (ASUS)

### Paso 1. Instalar Claude Code

1. Presiona la tecla **Windows**, escribe `PowerShell` y ábrelo.
2. Copia y pega este comando y presiona **Enter**:
   ```powershell
   irm https://claude.ai/install.ps1 | iex
   ```
3. Cuando termine, **cierra PowerShell y vuelve a abrirlo** para que reconozca el comando nuevo.
4. Para comprobar que quedó instalado, escribe:
   ```powershell
   claude --version
   ```
   Si aparece un número de versión, quedó instalado.

> Si te da error, instala **Git para Windows** (https://git-scm.com/download/win) y repite el paso 2.

### Paso 2. Iniciar sesión

1. En PowerShell escribe:
   ```powershell
   claude
   ```
2. Se abrirá el navegador. Inicia sesión con **la misma cuenta de Claude que usas en tu celular** (pinalabradorcarlosdavid@gmail.com).
3. Cuando diga que ya iniciaste sesión, escribe `/exit` para salir.

### Paso 3. Elegir la carpeta de trabajo

Claude va a trabajar dentro de la carpeta que elijas. Por ejemplo, para crear una carpeta `Proyectos`:

```powershell
mkdir $HOME\Proyectos
cd $HOME\Proyectos
```

Si tu proyecto ya está en otra carpeta, entra a ella con `cd` y la ruta de esa carpeta.

### Paso 4. Activar la conexión remota (Remote Control)

Dentro de esa carpeta, escribe:

```powershell
claude remote-control
```

Va a aparecer un enlace o un código QR. Así sabes que tu computadora ya está disponible para el celular.

**Deja esta ventana de PowerShell abierta.** Si la cierras, se corta la conexión.

### Paso 5. Evitar que la computadora se duerma

Si la computadora se suspende, el celular pierde la conexión.

1. Ve a **Configuración → Sistema → Energía y batería**.
2. En **Pantalla y suspensión**, pon **"Suspender el dispositivo después de"** en **Nunca**, sobre todo cuando esté **conectada a la corriente**.
3. Deja la laptop **conectada al cargador**.
4. Si vas a cerrar la tapa: ve a **Panel de control → Opciones de energía → Elegir el comportamiento al cerrar la tapa** y pon **"No hacer nada"** cuando esté conectada.

---

## Parte 2: preparar el celular

### Paso 6. Abrir tu computadora desde la app de Claude

1. Abre la app de **Claude** en tu celular (la misma cuenta).
2. Entra a la sección **Code**.
3. En la lista de sesiones aparecerá la de tu computadora. Si apareció un código QR en el paso 4, también puedes escanearlo con la cámara.
4. Ábrela y escribe tu orden. Por ejemplo: *"Crea una página web sencilla en esta carpeta"*. El trabajo se hace en tu ASUS.

### Paso 7. Activar las notificaciones de permisos

Así te enteras cuando Claude necesita tu aprobación aunque no estés viendo la app:

- **Android:** Ajustes → Aplicaciones → Claude → Notificaciones → **Activar**.
- **iPhone:** Ajustes → Notificaciones → Claude → **Permitir notificaciones**.

Cuando Claude quiera ejecutar un comando o modificar archivos, te llegará un aviso. Lo abres, revisas qué quiere hacer y tocas **Permitir** o **Rechazar**. Después Claude sigue trabajando.

---

## Qué puedes ver desde el celular

| Tipo de chat | ¿Lo ves en el celular? | ¿Puedes seguirlo? |
|---|---|---|
| Chats normales de Claude (claude.ai y la app) | Sí, todos, se sincronizan solos | Sí |
| La sesión de la computadora con `/remote-control` activo | Sí, en **Code** | Sí, y el trabajo se hace en la computadora |
| Sesiones viejas de Claude Code (sin `/remote-control`) | No | Solo si las retomas |

**Para retomar una sesión vieja desde el celular**, escribe en PowerShell:

```powershell
claude --resume
```

Elige la sesión con las flechas, presiona **Enter** y luego escribe `/remote-control`.

---

## Uso diario

### En la mañana, en la computadora (1 minuto)

1. Conecta la laptop al cargador y abre **PowerShell**.
2. Entra a tu carpeta de trabajo y abre Claude:
   ```powershell
   cd $HOME\Proyectos
   claude
   ```
3. Cuando aparezca el cuadro con `>`, escribe:
   ```
   /remote-control
   ```
   Debe decir **"/remote-control is active"** y abajo a la derecha **"/rc active"**.
4. Minimiza la ventana. **No la cierres.**

> Otra opción: escribir directamente `claude remote-control` en PowerShell hace lo mismo en un solo paso.

### Durante el día, desde el celular

- Abre la app de Claude → **Code** → la sesión de tu computadora (dice **"Remote control"** arriba).
- Escribe tus órdenes: *"crea…", "revisa…", "organiza mis archivos de…"*.
- Si Claude necesita permiso, te llega una **notificación**. La abres, lees qué quiere hacer y tocas **Permitir** o **Rechazar**.

### En la noche

Escribe `/exit` en la ventana de Claude en la computadora. O déjala corriendo si quieres seguir después.

---

## Automatizar: que se conecte solo al encender la computadora

Para no escribir `/remote-control` todos los días, pega esto **una sola vez** en PowerShell y presiona **Enter**:

```powershell
$startup = [Environment]::GetFolderPath('Startup')
@'
@echo off
title Claude Remote Control - NO CERRAR
cd /d "%USERPROFILE%"
claude remote-control
'@ | Set-Content -Path "$startup\Claude-Remote-Control.bat" -Encoding ASCII
powercfg /change standby-timeout-ac 0
powercfg /setacvalueindex SCHEME_CURRENT SUB_BUTTONS LIDACTION 0
powercfg /setactive SCHEME_CURRENT
```

Esto hace tres cosas:
1. Cada vez que enciendes la computadora e inicias sesión, se abre sola una ventana **"Claude Remote Control - NO CERRAR"** que activa la conexión.
2. La computadora no se suspende mientras esté conectada al cargador.
3. Al cerrar la tapa con el cargador conectado, la computadora sigue funcionando.

Desde el celular solo abres **Code** y ahí está tu computadora. Si cierras esa ventana por error, reinicia la computadora o escribe `claude remote-control` en PowerShell.

**Para quitarlo:** presiona `Windows + R`, escribe `shell:startup`, presiona **Enter** y borra el archivo `Claude-Remote-Control.bat`.

(También están los scripts en la carpeta `windows/` de este repositorio.)

---

## Ver en el celular un chat que hiciste en la computadora

Un chat de Claude Code de la computadora solo aparece en el celular mientras esté abierto con Remote Control. Los chats se guardan **según la carpeta donde los empezaste**:

1. En PowerShell, entra a la carpeta donde trabajaste ese chat. Por ejemplo:
   ```powershell
   cd "$HOME\Videos\Curso"
   ```
2. Escribe:
   ```powershell
   claude --resume
   ```
3. Elige el chat con las flechas y presiona **Enter**.
4. Escribe `/remote-control`. El chat aparecerá en tu celular, en **Code**.

---

## Elegir el modelo

En el celular, dentro de la sesión, puedes elegir qué versión de Claude hace el trabajo:

- **Opus 5.5:** el más capaz, para trabajos grandes o complicados.
- **Sonnet 5.5:** eficiente, sirve para casi todo.
- **Haiku 4.5:** el más rápido, para cosas sencillas.

**Si un modelo aparece en gris** con el aviso *"Update Claude Code on the computer running this session"*, no es problema de tu plan. El programa de la computadora está desactualizado. Para arreglarlo, en la misma ventana de PowerShell:

1. Escribe `/exit` para salir de Claude. PowerShell sigue abierto.
2. Escribe `claude update` y espera a que diga **"up to date"**.
3. Escribe `claude` y luego `/remote-control`.
4. En el celular, abre la sesión **nueva** de tu computadora.

---

## Configuración pendiente (una sola vez)

1. **Notificaciones en el iPhone:** Ajustes → Notificaciones → Claude → **Permitir notificaciones**. Activa también **Sonidos** y **Pantalla bloqueada**.
2. **Que la laptop no se duerma:** ver el Paso 5. Suspensión en **Nunca** cuando esté conectada y **"No hacer nada"** al cerrar la tapa.
3. **Carpeta de trabajo propia**, para que Claude no toque el resto de tus archivos personales:
   ```powershell
   mkdir $HOME\Proyectos
   ```
4. **Modo de permisos.** Se cambia con **Shift + Tab** en la ventana de Claude de la computadora:
   - **auto mode:** Claude hace solo lo de bajo riesgo y bloquea lo riesgoso. Te interrumpe menos.
   - **Modo normal** (sin "auto mode" abajo): te pregunta todo a ti en el celular. Es más seguro, pero te llegan más notificaciones.
5. **Opcional:** escribe `/config` dentro de Claude y busca una opción de **Remote Control** para activarlo siempre. Si existe en tu versión, ya no tendrás que escribir `/remote-control` cada vez.

---

## Cuando cambies a la Mac

1. Abre la app **Terminal**.
2. Instala Claude Code:
   ```bash
   curl -fsSL https://claude.ai/install.sh | bash
   ```
3. Repite los pasos 2, 3 y 4 (iniciar sesión, elegir carpeta y `claude remote-control`).
4. En **Configuración del Sistema → Batería / Pantalla de bloqueo**, evita que la Mac se suspenda mientras esté conectada.

En el celular no tienes que cambiar nada. La sesión de la Mac aparecerá en la misma lista.

---

## Problemas comunes

| Problema | Solución |
|---|---|
| `claude` no se reconoce como comando | Cierra y vuelve a abrir PowerShell. Si sigue igual, repite el Paso 1. |
| No veo mi computadora en el celular | Revisa que la ventana con `claude remote-control` siga abierta y que uses la misma cuenta en los dos. |
| Se desconectó mientras estaba fuera | La computadora se suspendió o perdió internet. Revisa el Paso 5 y vuelve a ejecutar `claude remote-control`. |
| No me llegan notificaciones | Revisa el Paso 7 y que el modo "No molestar" del celular esté apagado. |
| Opus u otro modelo aparece en gris | Actualiza Claude Code en la computadora (ver "Elegir el modelo"). |
| Escribí `cloud` y no funciona | Se escribe `claude` (c-l-a-u-d-e). |

## Consejo de seguridad

Lee siempre qué está pidiendo Claude antes de tocar **Permitir**, sobre todo si se trata de borrar archivos o instalar programas. Si no estás seguro, toca **Rechazar** y pregúntale por qué lo necesita.
