# Evento DeepDive Oracle



Para seguir este laboratorio, necesitas estar conectado a tu consola de Oracle Cloud Infrastructure.

## Contenido
[1  Creación y configuración del entorno](#sec-1)  
[1.1  Creación de la Autonomous AI Database](#sec-1.1)  
[1.2  Creación de la Wallet](#sec-1.2)    
[1.3  Creación de AI Data Platform](#sec-1.3)  
[2  Ingesta de datos](#sec-2)  
[2.1  Ingesta de datos vía Autonomous](#sec-2.1)  
[2.2  Ingesta de datos vía AIDP](#sec-2.2)  
[2.3  Creación de un catálogo dentro de AIDP](#sec-2.3)  
[2.4  Importación del notebook del laboratorio en el workspace](#sec-2.4)  
[2.5  Importación del notebook para la sesión 2](#sec-2.5)  


---
<a id="sec-1"></a>
### Paso 1 - Creación y configuración del entorno  



En este paso vamos a inicializar los servicios utilizados, crear una Autonomous AI Database y una AI Data Platform directamente desde la consola de OCI.  

<a id="sec-1.1"></a>
#### 1.1 - Creación de la Autonomous AI Database


Haz clic en el menú de hamburguesa, en la parte superior izquierda de la pantalla, para acceder al menú de servicios disponibles en OCI. Con el menú abierto, busca Oracle AI Database y Autonomous AI Database, y abre ese servicio.

<img width="1913" height="1030" alt="image" src="/images/15e75f59-ab1a-4395-afc0-f8c75fcd5b44" />  


Verifica que estés en el compartimento correcto (puedes crearla en cualquiera) y haz clic en el botón para crear Autonomous AI Database.

<img width="1890" height="642" alt="image-2" src="/images/d0134d24-bce9-4a46-b195-7db8700381b6" />



En la pantalla de creación, agrega el nombre de tu base de datos autónoma como `DeepDiveAutonomousDatabase` en ambos campos. Elige la opción Transaction Processing para el tipo de base de datos.

<img width="1896" height="972" alt="image-4" src="/images/59a45429-a30c-40ce-8695-a4af0f58eea6" />

Desplázate un poco más abajo y selecciona la versión de base de datos `26ai` y almacenamiento de 100GB en la configuración.

```sql
Workload type: Transaction Processing
Database version: 26ai ⚠️ Importante. Muchas características de IA están soportadas desde la versión 23ai
ECPU Count: 4 Recomendamos un número mayor a 2
Storage: Desde 256GB será suficiente para el demo
Access type: Secure Access from Everywhere
```

<img width="1302" height="372" alt="image-6" src="/images/a5ba0ac6-e375-4684-9aba-53884ac32d35" />

Por último, en la sección de credenciales de la misma pantalla, crea una contraseña que puedas recordar para el usuario administrador de la base de datos `admin`. La contraseña debe:
- Tener de 12 a 30 caracteres
- Tener al menos una letra mayúscula y un número
- No puede contener comillas dobles ni simples, ni el nombre del usuario

Cuando la contraseña sea correcta, haz clic en el botón inferior derecho para confirmar la información y continuar con la creación de la base de datos.

<img width="1912" height="990" alt="image-7" src="/images/9c9867c2-aa13-47fe-ae44-3a8a37511a40" />

El resto de la configuración debe dejarse con los valores predeterminados. Tu base de datos pasará al estado de aprovisionamiento y se abrirá automáticamente la siguiente pantalla.

<img width="1878" height="392" alt="image-8" src="/images/0f304048-0c35-408a-adf0-823242352de9" />

Espera hasta que el aprovisionamiento finalice y la base de datos quede activa.

<img width="1883" height="431" alt="image-9" src="/images/0df54478-57a7-4591-bc1c-fc7a4896d838" />

<a id="sec-1.2"></a>
#### 1.2 Descarga de la Wallet

En la página de la base de datos, junto al botón Database actions, encontramos el botón de conexiones. 

<img src="/images/image 6.png" />

Aquí podremos descargar la Wallet

<img src="/images/image 7.png" />

Este paso pedirá una contraseña, puede ser la misma contraseña que proporcionamos al crear la base de datos. Si todo se ejecutó correctamente, un archivo .zip será descargado.


<a id="sec-1.3"></a>
#### 1.3 Creación de AI Data Platform

Al igual que con la base de datos, vamos a iniciar la creación de la plataforma de datos. En ella podremos crear un catálogo, administrar volúmenes, manipular datos e incluso crear aplicaciones inteligentes. La plataforma de datos es el eje central de una buena estrategia de datos. Para iniciar la creación, entra al menú lateral y busca `Analytics & AI`; al hacer clic en esa opción, accede al servicio `AI Data Platform Workbench`.

<img width="1912" height="975" alt="image-10" src="/images/4a8a4382-9635-441b-b0f8-95ca3b210718" />

Confirma que estás en el compartimento correcto; igual que en Autonomous, este servicio puede crearse en cualquier compartimento de tu elección. Luego haz clic en el botón de creación.

<img width="1896" height="392" alt="image-12" src="/images/8d6231f0-e820-4efa-b269-2ca27855da3a" />

En la pantalla de creación vamos a completar algunas propiedades. Primero agregaremos un nombre para el AIDP y otro para el espacio de trabajo interno (workspace). Usaremos `DeepDiveAIDP` y `DeepDiveWorkspace`.

<img width="1892" height="977" alt="image-14" src="/images/db01d12a-662e-4b65-9446-9c2a7f60f388" />

Baja en la pantalla, selecciona la opción ALH para crear uno nuevo y agrega una contraseña para la plataforma. Recomendamos usar la misma del Autonomous para facilitar el proceso.

<img width="1447" height="558" alt="image-15" src="/images/0d92b281-53e8-4f68-88f6-9f353f161077" />

Para finalizar, selecciona la opción Standard en políticas de seguridad y haz clic en el botón de creación para confirmar la configuración.

<img width="1906" height="885" alt="image-16" src="/images/e11fe0a0-6f83-4f4c-b8de-1a45506f9f9f" />

En ese momento serás redirigido a la pantalla inicial del servicio, con tu AIDP en estado de creación.

<img width="1457" height="328" alt="image-17" src="/images/ece11ab6-2d0d-46e8-a58c-fc60d5402375" />

---
<a id="sec-2"></a>
### Paso 2 - Ingesta de datos  


<a id="sec-2.1"></a>
#### 2.1 Ingesta de datos vía Autonomous

En este laboratorio haremos dos tipos de ingesta: una directamente en Autonomous y otra en AIDP (sección 2.2). Accede a tu instancia activa en Autonomous.

<img width="1913" height="1030" alt="image" src="/images/15e75f59-ab1a-4395-afc0-f8c75fcd5b44" />


Haz clic en el nombre de la base de datos.

<img width="1745" height="147" alt="image-18" src="/images/8295a07b-00cf-475a-9d05-5162b971997e" />


Dentro de la pantalla de la base de datos, abre el menú de `database actions` y haz clic en `SQL`. Esta acción abrirá el workspace de la base para ejecutar SQL.

<img width="1907" height="692" alt="image-20" src="/images/6f50ecf6-b81b-4e36-a868-63a40fd25081" />


En la pantalla de SQL, ejecuta el siguiente comando:

````sql
CREATE TABLE BRONZE_WC_MATCHES (
    key_id NUMBER,
    tournament_id VARCHAR2(50),
    tournament_name VARCHAR2(200),
    match_id VARCHAR2(100),
    match_name VARCHAR2(200),
    stage_name VARCHAR2(100),
    group_name VARCHAR2(100),
    group_stage NUMBER,
    knockout_stage NUMBER,
    replayed NUMBER,
    replay NUMBER,
    match_date VARCHAR2(50),
    match_time VARCHAR2(50),
    stadium_id VARCHAR2(50),
    stadium_name VARCHAR2(200),
    city_name VARCHAR2(100),
    country_name VARCHAR2(100),
    home_team_id VARCHAR2(50),
    home_team_name VARCHAR2(100),
    home_team_code VARCHAR2(10),
    away_team_id VARCHAR2(50),
    away_team_name VARCHAR2(100),
    away_team_code VARCHAR2(10),
    score VARCHAR2(20),
    home_team_score NUMBER,
    away_team_score NUMBER,
    home_team_score_margin NUMBER,
    away_team_score_margin NUMBER,
    extra_time NUMBER,
    penalty_shootout NUMBER,
    score_penalties VARCHAR2(20),
    home_team_score_penalties NUMBER,
    away_team_score_penalties NUMBER,
    result VARCHAR2(50),
    home_team_win NUMBER,
    away_team_win NUMBER,
    draw NUMBER
);
````


Ejecuta el comando con el botón verde `Run Statement`.

<img width="1910" height="574" alt="image-21" src="/images/acccea84-7850-450b-925f-a1edeb35a516" />


Este comando crea una tabla con la estructura requerida, con todas las columnas y tipos listados. Luego copiaremos los datos a la tabla ejecutando el siguiente comando:

````BEGIN
  DBMS_CLOUD.COPY_DATA(
    table_name      => 'BRONZE_WC_MATCHES',
    credential_name => NULL,
    file_uri_list   => 'https://objectstorage.us-chicago-1.oraclecloud.com/n/axzegnybkron/b/DeepDiveWorkshopData/o/worldcup_matches.csv',
    format          => json_object(
      'type' value 'CSV',
      'skipheaders' value '1'
    )
  );
END;
````


Este comando busca el CSV en un repositorio público y copia sus datos a la tabla creada anteriormente. Después de ejecutarlo, puedes visualizar los datos con un SELECT, agregue este comando a continuación y haga clic en ejecutar nuevamente.

````
SELECT * FROM BRONZE_WC_MATCHES
````


<img width="1508" height="568" alt="image-22" src="/images/6915ad7d-d8c7-4c55-8caa-1482bd686712" />


También puedes verlo en la propia consola, buscando el nombre de la tabla en el panel lateral, haciendo clic derecho y seleccionando `Open`.

<img width="722" height="523" alt="image-23" src="/images/02ed2fe2-b542-47a3-b849-77c009706b5e" />


Se abrirá automáticamente una pestaña lateral con los datos de la tabla, columnas, datos, triggers y otras propiedades.

<img width="1913" height="1031" alt="image-24" src="/images/e4a22a20-e804-43ea-a52e-52ad7c777d1e" />

<a id="sec-2.2"></a>
#### 2.2 Ingesta de datos vía AIDP


A continuación, haremos la ingesta del segundo dataset de otra forma, usando AIDP. Para eso, accede al AIDP creado anteriormente.

<img width="1912" height="975" alt="image-10" src="/images/4a8a4382-9635-441b-b0f8-95ca3b210718" />


Haz clic en el nombre de tu plataforma de datos para entrar e iniciar sesión.

<img width="1467" height="392" alt="image-25" src="/images/104dd9c1-8a43-43c9-9ef3-8ebd5229fea8" />


Esta es la página principal de AIDP. En el menú lateral ya puedes ver tu catálogo de datos, workspace, workflows, agentes y demás información.

<img width="1901" height="550" alt="image-27" src="/images/580b399f-bd3a-4ef3-9233-5f8f95c59be4" />


<a id="sec-2.3"></a>
#### 2.3 Creación de un catálogo dentro de AIDP


Primero crearemos un catálogo apuntando al Autonomous que creamos antes. Para ello, haz clic en `create` en el menú lateral.

<img width="1547" height="463" alt="image-28" src="/images/1f78b5f4-13cc-434e-a379-fc297cdc8ade" />


El nombre de nuestro catálogo será `DeepDiveCatalog_Bronze` y usaremos conexión externa, seleccionando el Autonomous previamente creado. Completa el resto de la información como en la imagen.

<img width="1905" height="1026" alt="image-30" src="/images/03d7af96-a415-4f3a-80e7-184ae9704bd9" />


Después de elegir el servicio, debes ingresar la misma contraseña de Autonomous en los campos de wallet y contraseña, y dejar el usuario como `admin`. Prueba la conexión antes de continuar con el botón de crear. Si es correcta, procede con la creación.

<img width="1045" height="548" alt="image-32" src="/images/bf8b6c9a-dd04-41e3-8972-bf173f9f2f06" />


Tu catálogo iniciará el proceso de creación.

<img width="1234" height="53" alt="image-33" src="/images/40831924-3c9a-449d-a14f-913977ccba9e" />


Cuando finalice, ya podrás visualizar las tablas existentes en Autonomous con su respectivo esquema.

<img width="368" height="175" alt="image-34" src="/images/7e69ac71-f59a-49a9-a180-7dacf528a33a" />


<a id="sec-2.4"></a>
#### 2.4 Importación del notebook del laboratorio en el workspace


Para importar el notebook, primero accede al workspace desde el menú lateral.

<img width="1908" height="552" alt="image-35" src="/images/7d79eb5d-b225-4e3b-ab52-1d16164bc6c8" />


El workspace ya trae una carpeta llamada `Shared` con ejemplos. Para importar el notebook del laboratorio, primero debes descargarlo en tu máquina. Luego haz clic en el botón de upload (icono indicado en la imagen).

<img width="1907" height="432" alt="image-37" src="/images/37850300-084e-432b-84d9-7fd5cc83948a" />


Busca el archivo en tu repositorio y haz clic en upload para subirlo.

<img width="1237" height="1017" alt="image-38" src="/images/c48bb726-67b4-4d90-b247-7292d708466a" />


El archivo se agregará inmediatamente al workspace. Ya puedes abrirlo haciendo clic en el nombre del notebook.

<img width="800" height="88" alt="image-39" src="/images/0a94086a-bf69-4213-ad3f-1a511f3e2702" />


Al abrir el notebook, en la parte superior central verás `no cluster attached`. Llegamos así al último paso de configuración para poder realizar todos los laboratorios de las sesiones 1 y 2: crear el cluster. Haz clic en el botón de cluster (arriba a la derecha) y luego en `Create Cluster`.

<img width="1647" height="413" alt="image-40" src="/images/624bb611-e2c6-45b4-96e7-070b9f42e091" />


Se abrirá una pestaña; agrega el nombre y la configuración deseada. En nuestro caso usamos `DeepDiveCluster`, dejando la configuración por defecto y haciendo clic en `Create`.

<img width="1323" height="998" alt="image-42" src="/images/5c162ec8-ef44-47b9-b82e-1b834e1f079a" />


Espera a que el cluster se cree. Si no se adjunta automáticamente al notebook, vuelve al botón de cluster y busca `attach a cluster`, seleccionando el que acabas de crear.

<img width="1315" height="301" alt="image-43" src="/images/09977d3e-af1c-49bf-9a81-9ad2ba7431f6" />


Hasta que el cluster quede activo en el notebook.

<img width="505" height="74" alt="image-44" src="/images/ac673755-9172-4751-b9db-e974a39baa82" /> <img width="490" height="77" alt="image-45" src="/images/447118ef-acff-4b1c-aa8b-c32c9a213cd4" />

<a id="sec-2.5"></a>
#### 2.5 Importación del notebook para la sesión 2


Repite el mismo proceso de upload para el archivo Jupyter de la segunda sesión.

<img width="1238" height="1017" alt="image-46" src="/images/23809cbb-1f90-45de-8fa2-7d45708e4cf1" />


Con eso tendrás todos los notebooks necesarios para realizar las sesiones prácticas directamente en tu workspace.

<img width="1646" height="437" alt="image-47" src="/images/c2e2771f-911f-41aa-bf37-1db0d766338a" />


Ahora tienes un entorno completamente configurado y puedes seguir las instrucciones del propio Jupyter junto con el instructor para ejecutar los laboratorios.



