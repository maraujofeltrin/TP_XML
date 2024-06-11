# Trabajo Práctico Integrador XML

## Descripción
 - Este es un trabajo en el cual se obtienen dos archivos XML mediante una API (SportRadar) y luego se procesan dichos archivos para obtener la información relevante. En este caso, los resultados se presentan en una tabla dentro del archivo PDF generado al final de la ejecución.

## Requisitos
- **Software necesario:**
    - Es necesario tener correctamente instalados 2 parsers:
        - Saxon (cualquier versión)
        - Xerces (cualquier versión)

        Dichos parsers serán utilizados por el script en un entorno de bash.   
    - dos2unix   
    - Java JDK 11 o superior.

## Instalación
- Descomprime la carpeta `TPE_G1.zip` en el directorio donde se desea obtener el archivo PDF resultante. 
- Si no tienes los softwares mencionados anteriormente instalados en tu sistema, puedes descargarlos e instalarlos siguiendo estos pasos:

  1. ```bash 
     $> sudo apt install dos2unix
     ```

  2. ```bash
     $> sudo apt install openjdk-11-jdk
     ```

## Aclaraciones
- En caso de que el script no genere el archivo PDF, vuelve a revisar el software previamente mencionado y reintenta.
- El script genera un archivo PDF incluso si ocurre un error de procesamiento. Por lo tanto, si no se genera, implica que falta algún requisito.
- El único archivo que se puede eliminar luego de la finalización del programa es el archivo PDF. Si se elimina alguno de los otros archivos, el funcionamiento del script fallará.

## Uso
1. Ubicarse en el directorio donde se encuentra el archivo `TPE.sh`
1.  Ejecutar previamente el comando 
```bash
    $> dos2unix ./TPE.sh
 ```
para asegurar que el archivo este en condiciones de ser ejecutado en bash.

2. Luego, realiza el llamado al archivo `TPE.sh` de la siguiente manera, donde `$year` es el año del que se desean ver los resultados y `$type` es el tipo de competición:
```bash
    $> ./TPE.sh $year $type
 ```

3. Se generará un archivo llamado `nascar_report.pdf` en el directorio donde se encuentran todos los archivos. Tiene 2 salidas posibles:
    - Una tabla con los resultados de la información solicitada. 
    - Un mensaje de error que indica el fallo.   

