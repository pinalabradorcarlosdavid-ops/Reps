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

## Uso diario (resumen rápido)

Cada vez que quieras trabajar desde el celular:

1. Enciende la computadora, conéctala al cargador y abre **PowerShell**.
2. Escribe:
   ```powershell
   cd $HOME\Proyectos
   claude remote-control
   ```
3. Deja la ventana abierta y sal tranquilo.
4. Desde el celular: app de Claude → **Code** → tu sesión → da órdenes y aprueba permisos.

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

## Consejo de seguridad

Lee siempre qué está pidiendo Claude antes de tocar **Permitir**, sobre todo si se trata de borrar archivos o instalar programas. Si no estás seguro, toca **Rechazar** y pregúntale por qué lo necesita.
