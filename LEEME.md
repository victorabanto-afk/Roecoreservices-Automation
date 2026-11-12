# karate-labroe

## Ejecutar
1. Descomprime el zip y abre la carpeta en VS Code (File > Open Folder).
2. Abre la terminal (Ctrl+ñ) y ejecuta:

       .\run.ps1

   Te pedira la contrasena y luego correra `mvnw.cmd test`
   (la primera vez descarga Maven y las dependencias).

   Si PowerShell bloquea el script:
       Set-ExecutionPolicy -Scope Process Bypass
   y vuelve a ejecutar .\run.ps1

3. Reporte: target/karate-reports/karate-summary.html

## Agregar mas endpoints
Crea un .feature en src/test/java/features/ con:

    Background:
      * url baseUrl
      * headers authHeader

El token se obtiene una sola vez en karate-config.js.
