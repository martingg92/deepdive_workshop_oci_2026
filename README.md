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
[3  Workshop AI Database Agent Factory](#sec-3)  
[3.1  Creación de una Red](#sec-3.1)  
[3.2  Despliegue del Marketplace](#sec-3.2)  
[3.3  Navegación por la Plataforma](#sec-3.3)  
[3.4  Laboratorio: Construcción de un agente a partir de datos de partidos](#sec-3.4)  
[3.4.1  Paso 1: Carga de los datos en la base de datos](#sec-3.4.1)  
[3.4.2  Paso 2: Creación de un agente para análisis de datos](#sec-3.4.2)  
[3.4.3  Paso 3: Uso del agente para análisis de datos](#sec-3.4.3)  


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

<a id="sec-3"></a>
### Paso 3 - Creación de una red 

En la consola de Oracle, podemos configurar una red virtual privada dentro de nuestro compartment.

<aside>
💡

Networking > Virtual Cloud Networks

</aside>

Es importante seleccionar nuestro compartment, una vez seleccionado procedemos a la creación.

<img src="/images/image 8.png" />

Vamos a crear una red con acceso a internet

<img src="/images/image 9.png" />

En la creación solamente debemos seleccionar un nombre

```sql
Name: vcn-agent
```

El resto de los valores pueden dejarse por defecto, al presionar Next y luego Create, podemos esperar unos segundos por la creación de la vcn.

<a id="sec-3.1"></a>
#### 3.1 Configuración de puertos

Cuando la VCN se haya creado correctamente, en el panel Security podremos ver el bloque de listas de seguridad Security Lists

<img src="/images/image 10.png" />

Podemos seleccionar la lista de seguridad por default, su nombre empezará por el texto Default Security List for …

<img src="/images/image 11.png" />

Dentro de la lista se seguridad podemos navegar a Security rules, en donde debemos agregar las reglas de ingreso

<img src="/images/image 12.png" />

<img src="/images/image 13.png" />

Agregaremos las siguientes reglas:

<img src="/images/image 14.png" />

```sql
Source CIDR: 0.0.0.0/0
Destination Port Range: 8080
```

<img src="/images/image 15.png" />

```sql
Source CIDR: 0.0.0.0/0
Destination Port Range: 1521
```

Para confirmar la creación seleccionamos Add Ingress Rules

<img src="/images/image 16.png" />

<a id="sec-3.2"></a>
#### 3.2 Despliegue del marketplace

[Link Marketplace](https://marketplace.oracle.com/listings/201588705 "Link Marketplace")


</details>

Ahora vamos a navegar hasta el marketplace, en la consola de Oracle podemos navegar a

<aside>
💡

Marketplace > All Applications

</aside>

Allí veremos una barra de búsqueda

<img src="/images/image 17.png" />

En donde podemos buscar la siguiente aplicación

```sql
Oracle AI Database Private Agent Factory
```

<img src="/images/image 18.png" />

Aquí podemos seleccionar la app y crear el stack

<img src="/images/image 19.png" />

Es importante seleccionar nuestro compartment, una vez seleccionado procedemos a la creación.

<img src="/images/image 20.png" />

Para el lanzamiento del stack hay 3 steps.

> 1️⃣ Stack information

En el primer paso solamente tenemos que especificar un nombre y una descripción. Podemos dejar la descripción por defecto.

> 2️⃣ Configure variables

En el segundo paso hay tres bloques.

**General settings**
```
Region: us-chicago-1
VM compartment: El compartment que creamos previamente.
Subnet compartment: El compartment que creamos previamente. 
```

**Network Configuration**
```sql
VCN: La VCN creada previamente
Existing subnet: La subred pública
Public or Private subnet: public
```

**Agent Factory VM**
```
Agent Factory server display name: AgentFactoryVM
Agent Factory server shape: VM.Standard.E5.Flex
```

**Public ssh key file**

> Para la instalacion es requerida una llave publica, si no lo tienes puedes generarla asi:


📸 **Generacion de Llaves privadas/publicas**


Abre una ventana de Powershell en la carpeta donde se desee generar las llaves, luego ejecuta el siguiente comando:
```powershell
ssh-keygen -t rsa -b 4096 -f .\oraclelabs
```


- Agrega la llave `publica` , esta llave termina en .pub. Windows puede confundir la extensión como parte de Microsoft Publisher.

<img src="/images/image 39.png" />

Este step toma 3 o 4 minutos.

El botón de creación nos lleva a la página del Stack en donde podemos ver los jobs de ejecución, si todo se ejecutó correctamente el último log mostrará un link.

> 3️⃣ Review

En este paso debemos revisar la configuración, si todo está bien, podemos lanzar el stack.


### Paso 6.1: Registro y conexión

Al ingresar al link tenemos una página de registro

<img src="/images/image 25.png" />

Después del registro podemos realizar la conexión a la base de datos, para esto usaremos la wallet descargada.

<img src="/images/image 26.png" />

Usemos la siguiente configuración para la wallet.

```
Air-gapped environment: No
Does the database server use a wallet? Yes
Are the OCI certificates added to the wallet? Yes
```


Al testear la conexión aparecerá un mensaje de conexión exitosa si la conexión a la base de datos fue exitosa.

<img src="/images/image 27.png" />

Al presionar siguiente podemos ver los logs de instalación.

En el paso 4 será necesario configurar el modelo de lenguaje

<img src="/images/image 28.png" />



```yaml
Model id: meta.llama-4-maverick-17b-128e-instruct-fp8 # o cualquier modelo disponible en https://cloud.oracle.com/ai-service/generative-ai/playground/chat
Endpoint: https://inference.generativeai.us-chicago-1.oci.oraclecloud.com # Cambiar según la región
Compartment ID: ocid1.compartment... # Id del compartment creado. Disponible en Identity and Security > Compartments
User ID: ocid1.user.oc1... # User id. Disponible en Identity > My profile 

```

<img src="/images/image 29.png" />

Al hacer scroll hacia abajo aparecerá la opción de agregar modelos de embeddings

<img src="/images/image 30.png" />

Al seleccionar OCI Gen AI, aparecerá un formulario parecido al anterior, aquí cambiará únicamente el id del modelo

```yaml
Model id: cohere.embed-multilingual-image-v3.0 # o cualquier modelo disponible en https://cloud.oracle.com/ai-service/generative-ai/playground/embed
Endpoint: https://inference.generativeai.us-chicago-1.oci.oraclecloud.com # Cambiar según la región
Compartment ID: ocid1.compartment... # Id del compartment creado. Disponible en Identity and Security > Compartments
User ID: ocid1.user.oc1... # User id. Disponible en Identity > My profile 

```

Al completar los campos y si las conexiones son exitosas, podemos continuar la instalación

<img src="/images/image 31.png" />

<img src="/images/image 32.png" />

<a id="sec-3.3"></a>
#### 3.3 Navegación por la plataforma

Al finalizar la instalación podemos observar una plataforma que se ve de la siguiente manera.

<img src="/images/dpaf home.png" />

Ahora podemos construir nuestros propios flujos de inteligencia artificial.

<a id="sec-3.4"></a>
#### 3.4 Laboratorio: Construcción de un agente a partir de datos de partidos

Los datos son uno de los activos más valiosos de cualquier organización, pero acceder a ellos de forma ágil e intuitiva sigue siendo un reto para muchos equipos. 🤔 En este laboratorio vas a construir un agente de análisis de datos sobre estadísticas históricas de la **Copa Mundial de Fútbol 2022** ⚽ — un agente que entiende preguntas en lenguaje natural, las traduce automáticamente a consultas SQL y te devuelve respuestas, tablas y visualizaciones al instante, sin que tengas que escribir una sola línea de código. 🚀

---

<a id="sec-3.4.1"></a>
##### 3.4.1 Paso 1: Carga de los datos en la base de datos

> Carga de datos Premier League de forma automática. 

<details>
<summary>📸 Creación y Cargas de datos PREMIER LEAGUE de forma automática </summary>

```sql
-- Script para Autonomous Database ejecutado con usuario ADMIN
-- Ejecutar con F5

SET DEFINE OFF;

PROMPT === Eliminando tablas si existen ===

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE EVENT PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE MATCH PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE PREDICT_BY_ANGLE PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE XG_MATRIX PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE PLAYER_STATS PURGE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN
      RAISE;
    END IF;
END;
/

PROMPT === Creando tablas ===

CREATE TABLE EVENT
(
  ID                            NUMBER(38,0),
  MATCH_ID                      VARCHAR2(26 BYTE),
  EVENT_ID                      NUMBER(38,0),
  TYPE_ID                       NUMBER(38,0),
  PERIOD_ID                     NUMBER(38,0),
  TIME_MIN                      NUMBER(38,0),
  TIME_SEC                      NUMBER(38,0),
  MATCH_DATE                    DATE,
  TEAM_ID                       VARCHAR2(26 BYTE),
  X                             NUMBER(38,1),
  Y                             NUMBER(38,1),
  PLAYER_ID                     VARCHAR2(26 BYTE),
  PLAYER_NAME                   VARCHAR2(26 BYTE),
  PENALTY                       VARCHAR2(26 BYTE),
  HEAD                          VARCHAR2(26 BYTE),
  RIGHT_FOOTED                  VARCHAR2(26 BYTE),
  OTHER_BODY_PART               VARCHAR2(26 BYTE),
  REGULAR_PLAY                  VARCHAR2(26 BYTE),
  FAST_BREAK                    VARCHAR2(26 BYTE),
  SET_PIECE                     VARCHAR2(26 BYTE),
  FROM_CORNER                   VARCHAR2(26 BYTE),
  FREE_KICK                     VARCHAR2(26 BYTE),
  OWN_GOAL                      VARCHAR2(26 BYTE),
  ASSISTED                      VARCHAR2(26 BYTE),
  LEFT_FOOTED                   VARCHAR2(26 BYTE),
  TARGETED_LOW_LEFT             VARCHAR2(26 BYTE),
  TARGETED_HIGH_LEFT            VARCHAR2(26 BYTE),
  TARGETED_LOW_CENTER           VARCHAR2(26 BYTE),
  TARGETED_HIGH_CENTER          VARCHAR2(26 BYTE),
  TARGETED_LOW_RIGHT            VARCHAR2(26 BYTE),
  TARGETED_HIGH_RIGHT           VARCHAR2(26 BYTE),
  BLOCKED                       VARCHAR2(26 BYTE),
  TARGETED_CLOSE_LEFT           VARCHAR2(26 BYTE),
  TARGETED_CLOSE_RIGHT          VARCHAR2(26 BYTE),
  TARGETED_CLOSE_HIGH           VARCHAR2(26 BYTE),
  TARGETED_CLOSE_LEFT_AND_HIGH  VARCHAR2(26 BYTE),
  TARGETED_CLOSE_RIGHT_AND_HIGH VARCHAR2(26 BYTE),
  PROJECTED_GOAL_MOUTH_Y        VARCHAR2(26 BYTE),
  PROJECTED_GOAL_MOUTH_Z        VARCHAR2(26 BYTE),
  DEFLECTION                    VARCHAR2(26 BYTE),
  HIT_WOODWORK                  VARCHAR2(26 BYTE),
  BIG_CHANCE                    VARCHAR2(26 BYTE),
  INDIVIDUAL_CHANCE             VARCHAR2(26 BYTE),
  HIT_RIGHT_POST                VARCHAR2(26 BYTE),
  HIT_LEFT_POST                 VARCHAR2(26 BYTE),
  HIT_BAR                       VARCHAR2(26 BYTE),
  OUT_ON_SIDELINE               VARCHAR2(26 BYTE),
  KICKOFF                       VARCHAR2(26 BYTE),
  FIRST_TOUCH                   VARCHAR2(26 BYTE),
  NOT_ASSISTED                  VARCHAR2(26 BYTE),
  EVENT_TYPE_NAME               VARCHAR2(10 BYTE),
  TEAM_NAME                     VARCHAR2(50 BYTE),
  IS_GOAL                       VARCHAR2(1 BYTE),
  GOAL_CNT                      NUMBER(1,0),
  RESULT                        VARCHAR2(20 BYTE),
  TEAM_SIDE                     VARCHAR2(4 BYTE),
  X_REL_PC                      NUMBER,
  Y_REL_PC                      NUMBER,
  X_REL_M                       NUMBER,
  Y_REL_M                       NUMBER,
  X_REL_M_TEAM                  NUMBER,
  Y_REL_M_TEAM                  NUMBER,
  DISTANCE                      NUMBER,
  DISTANCE_BUCKET               NUMBER,
  EVENT_COUNT                   NUMBER,
  FOOTBALL_PITCH_CELL           VARCHAR2(10 BYTE)
);

CREATE TABLE MATCH
(
  MATCH_ID       VARCHAR2(26 BYTE),
  MATCH_DATE     DATE,
  MATCH_TIME     VARCHAR2(26 BYTE),
  TEAM_HOME_ID   VARCHAR2(26 BYTE),
  TEAM_HOME_NAME VARCHAR2(26 BYTE),
  TEAM_AWAY_ID   VARCHAR2(26 BYTE),
  TEAM_AWAY_NAME VARCHAR2(26 BYTE),
  VENUE          VARCHAR2(128 BYTE),
  STATUS         VARCHAR2(26 BYTE),
  WINNER         VARCHAR2(26 BYTE),
  SCORE_HOME     NUMBER(38,0),
  SCORE_AWAY     NUMBER(38,0),
  NAME           VARCHAR2(100 BYTE),
  NAME_DATE      VARCHAR2(100 BYTE)
);

CREATE TABLE PREDICT_BY_ANGLE
(
  ID             NUMBER,
  ANGLE          NUMBER,
  PREDICTED_GOAL VARCHAR2(1 BYTE),
  XG             NUMBER
);

CREATE TABLE XG_MATRIX
(
  ID                 NUMBER,
  X                  NUMBER,
  Y                  NUMBER,
  ANGLE              NUMBER,
  HEAD               VARCHAR2(1 BYTE),
  FAST_BREAK         VARCHAR2(1 BYTE),
  PREDICTED_GOAL     VARCHAR2(1 BYTE),
  XG                 NUMBER,
  FOOTBALL_PITCH_CELL VARCHAR2(10 BYTE)
);

CREATE TABLE PLAYER_STATS
(
  PLAYER_ID   VARCHAR2(26 BYTE),
  PLAYER_NAME VARCHAR2(26 BYTE),
  TEAM_NAME   VARCHAR2(50 BYTE),
  TOTAL_XG    NUMBER,
  GOALS       NUMBER,
  SHOT_COUNT  NUMBER,
  XG_PER_SHOT NUMBER
);

-- Tabla de staging para EVENT (el CSV trae MATCH_DATE al final)
CREATE TABLE EVENT_RAW
(
  ID                            VARCHAR2(100 BYTE),
  MATCH_ID                      VARCHAR2(26 BYTE),
  EVENT_ID                      VARCHAR2(100 BYTE),
  TYPE_ID                       VARCHAR2(100 BYTE),
  PERIOD_ID                     VARCHAR2(100 BYTE),
  TIME_MIN                      VARCHAR2(100 BYTE),
  TIME_SEC                      VARCHAR2(100 BYTE),
  TEAM_ID                       VARCHAR2(26 BYTE),
  X                             VARCHAR2(100 BYTE),
  Y                             VARCHAR2(100 BYTE),
  PLAYER_ID                     VARCHAR2(26 BYTE),
  PLAYER_NAME                   VARCHAR2(26 BYTE),
  PENALTY                       VARCHAR2(26 BYTE),
  HEAD                          VARCHAR2(26 BYTE),
  RIGHT_FOOTED                  VARCHAR2(26 BYTE),
  OTHER_BODY_PART               VARCHAR2(26 BYTE),
  REGULAR_PLAY                  VARCHAR2(26 BYTE),
  FAST_BREAK                    VARCHAR2(26 BYTE),
  SET_PIECE                     VARCHAR2(26 BYTE),
  FROM_CORNER                   VARCHAR2(26 BYTE),
  FREE_KICK                     VARCHAR2(26 BYTE),
  OWN_GOAL                      VARCHAR2(26 BYTE),
  ASSISTED                      VARCHAR2(26 BYTE),
  LEFT_FOOTED                   VARCHAR2(26 BYTE),
  TARGETED_LOW_LEFT             VARCHAR2(26 BYTE),
  TARGETED_HIGH_LEFT            VARCHAR2(26 BYTE),
  TARGETED_LOW_CENTER           VARCHAR2(26 BYTE),
  TARGETED_HIGH_CENTER          VARCHAR2(26 BYTE),
  TARGETED_LOW_RIGHT            VARCHAR2(26 BYTE),
  TARGETED_HIGH_RIGHT           VARCHAR2(26 BYTE),
  BLOCKED                       VARCHAR2(26 BYTE),
  TARGETED_CLOSE_LEFT           VARCHAR2(26 BYTE),
  TARGETED_CLOSE_RIGHT          VARCHAR2(26 BYTE),
  TARGETED_CLOSE_HIGH           VARCHAR2(26 BYTE),
  TARGETED_CLOSE_LEFT_AND_HIGH  VARCHAR2(26 BYTE),
  TARGETED_CLOSE_RIGHT_AND_HIGH VARCHAR2(26 BYTE),
  PROJECTED_GOAL_MOUTH_Y        VARCHAR2(26 BYTE),
  PROJECTED_GOAL_MOUTH_Z        VARCHAR2(26 BYTE),
  DEFLECTION                    VARCHAR2(26 BYTE),
  HIT_WOODWORK                  VARCHAR2(26 BYTE),
  BIG_CHANCE                    VARCHAR2(26 BYTE),
  INDIVIDUAL_CHANCE             VARCHAR2(26 BYTE),
  HIT_RIGHT_POST                VARCHAR2(26 BYTE),
  HIT_LEFT_POST                 VARCHAR2(26 BYTE),
  HIT_BAR                       VARCHAR2(26 BYTE),
  OUT_ON_SIDELINE               VARCHAR2(26 BYTE),
  KICKOFF                       VARCHAR2(26 BYTE),
  FIRST_TOUCH                   VARCHAR2(26 BYTE),
  NOT_ASSISTED                  VARCHAR2(26 BYTE),
  EVENT_TYPE_NAME               VARCHAR2(10 BYTE),
  TEAM_NAME                     VARCHAR2(50 BYTE),
  IS_GOAL                       VARCHAR2(1 BYTE),
  GOAL_CNT                      VARCHAR2(100 BYTE),
  RESULT                        VARCHAR2(20 BYTE),
  TEAM_SIDE                     VARCHAR2(4 BYTE),
  X_REL_PC                      VARCHAR2(100 BYTE),
  Y_REL_PC                      VARCHAR2(100 BYTE),
  X_REL_M                       VARCHAR2(100 BYTE),
  Y_REL_M                       VARCHAR2(100 BYTE),
  X_REL_M_TEAM                  VARCHAR2(100 BYTE),
  Y_REL_M_TEAM                  VARCHAR2(100 BYTE),
  DISTANCE                      VARCHAR2(100 BYTE),
  DISTANCE_BUCKET               VARCHAR2(100 BYTE),
  EVENT_COUNT                   VARCHAR2(100 BYTE),
  FOOTBALL_PITCH_CELL           VARCHAR2(10 BYTE),
  MATCH_DATE_TXT                VARCHAR2(30 BYTE)
);

PROMPT === Cargando datos con DBMS_CLOUD.COPY_DATA ===

BEGIN
  DBMS_CLOUD.COPY_DATA(
    credential_name => NULL,
    table_name      => 'EVENT_RAW',
    file_uri_list   => 'https://objectstorage.us-chicago-1.oraclecloud.com/p/JdLwvG46w3Kjs8e0gieB6mKUZdZhGOo6KcNTZGTThF-0JAzRc7eOqGl4510aPgOO/n/idajmumkp9ca/b/labs-git/o/event.csv',
    format          => '{"type":"csv","skipheaders":1,"delimiter":",","quote":"\"","characterset":"WE8MSWIN1252","blankasnull":true}'
  );

  INSERT INTO EVENT (
    ID, MATCH_ID, EVENT_ID, TYPE_ID, PERIOD_ID, TIME_MIN, TIME_SEC, MATCH_DATE,
    TEAM_ID, X, Y, PLAYER_ID, PLAYER_NAME, PENALTY, HEAD, RIGHT_FOOTED, OTHER_BODY_PART,
    REGULAR_PLAY, FAST_BREAK, SET_PIECE, FROM_CORNER, FREE_KICK, OWN_GOAL, ASSISTED,
    LEFT_FOOTED, TARGETED_LOW_LEFT, TARGETED_HIGH_LEFT, TARGETED_LOW_CENTER, TARGETED_HIGH_CENTER,
    TARGETED_LOW_RIGHT, TARGETED_HIGH_RIGHT, BLOCKED, TARGETED_CLOSE_LEFT, TARGETED_CLOSE_RIGHT,
    TARGETED_CLOSE_HIGH, TARGETED_CLOSE_LEFT_AND_HIGH, TARGETED_CLOSE_RIGHT_AND_HIGH,
    PROJECTED_GOAL_MOUTH_Y, PROJECTED_GOAL_MOUTH_Z, DEFLECTION, HIT_WOODWORK, BIG_CHANCE,
    INDIVIDUAL_CHANCE, HIT_RIGHT_POST, HIT_LEFT_POST, HIT_BAR, OUT_ON_SIDELINE, KICKOFF,
    FIRST_TOUCH, NOT_ASSISTED, EVENT_TYPE_NAME, TEAM_NAME, IS_GOAL, GOAL_CNT, RESULT, TEAM_SIDE,
    X_REL_PC, Y_REL_PC, X_REL_M, Y_REL_M, X_REL_M_TEAM, Y_REL_M_TEAM, DISTANCE,
    DISTANCE_BUCKET, EVENT_COUNT, FOOTBALL_PITCH_CELL
  )
  SELECT
    TO_NUMBER(ID DEFAULT NULL ON CONVERSION ERROR),
    MATCH_ID,
    TO_NUMBER(EVENT_ID DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(TYPE_ID DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(PERIOD_ID DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(TIME_MIN DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(TIME_SEC DEFAULT NULL ON CONVERSION ERROR),
    TO_DATE(TRIM(MATCH_DATE_TXT) DEFAULT NULL ON CONVERSION ERROR, 'DD-MON-RR'),
    TEAM_ID,
    TO_NUMBER(X DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(Y DEFAULT NULL ON CONVERSION ERROR),
    PLAYER_ID, PLAYER_NAME, PENALTY, HEAD, RIGHT_FOOTED, OTHER_BODY_PART,
    REGULAR_PLAY, FAST_BREAK, SET_PIECE, FROM_CORNER, FREE_KICK, OWN_GOAL, ASSISTED,
    LEFT_FOOTED, TARGETED_LOW_LEFT, TARGETED_HIGH_LEFT, TARGETED_LOW_CENTER, TARGETED_HIGH_CENTER,
    TARGETED_LOW_RIGHT, TARGETED_HIGH_RIGHT, BLOCKED, TARGETED_CLOSE_LEFT, TARGETED_CLOSE_RIGHT,
    TARGETED_CLOSE_HIGH, TARGETED_CLOSE_LEFT_AND_HIGH, TARGETED_CLOSE_RIGHT_AND_HIGH,
    PROJECTED_GOAL_MOUTH_Y, PROJECTED_GOAL_MOUTH_Z, DEFLECTION, HIT_WOODWORK, BIG_CHANCE,
    INDIVIDUAL_CHANCE, HIT_RIGHT_POST, HIT_LEFT_POST, HIT_BAR, OUT_ON_SIDELINE, KICKOFF,
    FIRST_TOUCH, NOT_ASSISTED, EVENT_TYPE_NAME, TEAM_NAME, IS_GOAL,
    TO_NUMBER(GOAL_CNT DEFAULT NULL ON CONVERSION ERROR),
    RESULT, TEAM_SIDE,
    TO_NUMBER(X_REL_PC DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(Y_REL_PC DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(X_REL_M DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(Y_REL_M DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(X_REL_M_TEAM DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(Y_REL_M_TEAM DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(DISTANCE DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(DISTANCE_BUCKET DEFAULT NULL ON CONVERSION ERROR),
    TO_NUMBER(EVENT_COUNT DEFAULT NULL ON CONVERSION ERROR),
    FOOTBALL_PITCH_CELL
  FROM EVENT_RAW;

  DBMS_CLOUD.COPY_DATA(
    credential_name => NULL,
    table_name      => 'MATCH',
    file_uri_list   => 'https://objectstorage.us-chicago-1.oraclecloud.com/p/bwcwEtC52h5gfON0nYqVOhDqPrH3hZT8Ck58bPmCKECLKHRrM5xY4265r1EOaz20/n/idajmumkp9ca/b/labs-git/o/match.csv',
    format          => '{"type":"csv","skipheaders":1,"delimiter":",","quote":"\"","characterset":"WE8MSWIN1252","dateformat":"DD-MON-RR","blankasnull":true}'
  );

  DBMS_CLOUD.COPY_DATA(
    credential_name => NULL,
    table_name      => 'PLAYER_STATS',
    file_uri_list   => 'https://objectstorage.us-chicago-1.oraclecloud.com/p/GSZXJEJkuXJjqhlHXxnm04kWX4OlnISgWVqtrVxxKLVm8pD36XO2oUj6h7unKLtw/n/idajmumkp9ca/b/labs-git/o/player_stats.csv',
    format          => '{"type":"csv","skipheaders":1,"delimiter":",","quote":"\"","characterset":"WE8MSWIN1252","blankasnull":true}'
  );

  DBMS_CLOUD.COPY_DATA(
    credential_name => NULL,
    table_name      => 'PREDICT_BY_ANGLE',
    file_uri_list   => 'https://objectstorage.us-chicago-1.oraclecloud.com/p/HIHoQBesfjAFk2Ekrq279NoBnrMozXvkTFxjtLXyVJlNx1zXapjX93X4t0y-REL-/n/idajmumkp9ca/b/labs-git/o/predict_by_angle.csv',
    format          => '{"type":"csv","skipheaders":1,"delimiter":",","quote":"\"","characterset":"WE8MSWIN1252","blankasnull":true}'
  );

  DBMS_CLOUD.COPY_DATA(
    credential_name => NULL,
    table_name      => 'XG_MATRIX',
    file_uri_list   => 'https://objectstorage.us-chicago-1.oraclecloud.com/p/nBNu_bNLWfWpha7W92NQnqo7AIcMuatbtiIbGfJe9i5sytXEXC9mq4xbpDFaHO2Q/n/idajmumkp9ca/b/labs-git/o/xg_matrix.csv',
    format          => '{"type":"csv","skipheaders":1,"delimiter":",","quote":"\"","characterset":"WE8MSWIN1252","blankasnull":true}'
  );
END;
/

PROMPT === Validar errores de carga (si existen) ===
SELECT * FROM USER_LOAD_OPERATIONS ORDER BY ID DESC FETCH FIRST 10 ROWS ONLY;

DROP TABLE EVENT_RAW PURGE;

COMMIT;

PROMPT === Carga finalizada ===

```


</details>

<details>
<summary>📸 Carga de documentos de forma manual </summary>




### Acceso a la pantalla principal

En la consola web de OCI, navega hasta la pantalla principal de la base de datos.
En esta pantalla, haz clic en el botón **Database Actions**.
Dentro del menú de Database Actions, presiona el botón **Data Load**.

![Botón Data en Database Actions]<img src="/images/dpaf_image3.png" />


Se abrirá un panel con el botón **Load Data**. Haz clic en él para continuar.

![Botón Load Data]<img src="/images/dpaf_image4.png" />

Verás un panel de carga donde puedes **arrastrar y soltar** tus archivos CSV, o hacer clic en **Select Files** para buscarlos manualmente.


Descarga los archivos CSV desde los siguientes enlaces:

- [Link 1]()
- [Link 2]()
- [Link 3]()

![Panel de arrastrar y soltar archivos]<img src="/images/dpaf_image6.png" />

> **Nota:** Los archivos CSV pueden estar separados por `,` (coma) o por `;` (punto y coma). La plataforma intentará detectarlo automáticamente — verifica este ajuste en el siguiente paso.

### Revisión de la configuración del dataset

Una vez cargado el archivo, aparecerá un bloque con el nombre del CSV. Este nombre corresponderá al nombre de la tabla que se creará en la base de datos. Verás una advertencia que dice **Review Settings**.

![Bloque de detección del dataset]<img src="/images/dpaf_image7.png" />

Haz clic en **Review Settings** y verifica lo siguiente:

- ✅ Los datos se cargaron correctamente
- ✅ Los tipos de datos de cada columna se detectaron de forma correcta
- ✅ El separador del CSV fue identificado correctamente (`,`,`;`, etc...)

Corrige cualquier ajuste que sea necesario antes de continuar. Una vez que todo esté en orden, la advertencia **Review Settings** desaparecerá del bloque.

### Ejecución de la carga

Con la configuración validada, haz clic en el botón **Start** para iniciar la transferencia de datos a la base de datos.

![Botón Start]<img src="/images/dpaf_image9.png" />

### Verificación de la carga exitosa

Al finalizar, el bloque mostrará el nombre del CSV junto con el **número de columnas y filas** que se cargaron correctamente. Confirma que estos valores coincidan con los de tu archivo original.

![Resumen de carga exitosa]<img src="/images/dpaf_image10.png" />

### Cierre del panel de carga

Una vez verificada la carga, haz clic en el botón **Close** para finalizar el proceso.

![Botón Close]<img src="/images/dpaf_image8.png" />

Con esto concluye la carga de los datos en la base de datos, que servirán para alimentar el agente que construiremos en la plataforma **Database Private Agent Factory (DPAF)**.

---

</details>

<a id="sec-3.4.2"></a>
##### 3.4.2 Paso 2: Creación de un agente para análisis de datos

Ingresa a la plataforma **Database Private Agent Factory (DPAF)**, que ya fue desplegada previamente. En el panel de navegación izquierdo, selecciona la opción **Data Source**.

Crea un nuevo Data Source de tipo **Database** completando el formulario con los siguientes campos:

- **Nombre:** un nombre descriptivo para identificar la conexión
- **Descripción:** una breve descripción del propósito de esta fuente de datos
- **Tipo de conexión:** carga la Wallet que descargaste al crear la base de datos
- **Usuario:** `ADMIN`
- **Contraseña:** la contraseña que definiste al crear la base de datos

![Formulario de configuración del Data Source]<img src="/images/dpaf_image12.png" />

Una vez completado el formulario, haz clic en **Test Connection** para validar que la conexión sea exitosa. Si la prueba es exitosa, presiona el botón **Add Database Source** para guardar la fuente de datos.

### Verificación del Data Source creado

Si la configuración fue correcta, el nuevo Data Source aparecerá listado en el panel de **Data Source** del menú izquierdo.

### Creación del agente de análisis

Vuelve al menú de navegación izquierdo y haz clic en **Data Analysis Agents**. Luego presiona el botón **Create Agent** para iniciar la configuración del agente.

![Panel de Data Analysis Agents]<img src="/images/dpaf_image13.png" />

![Botón Create Agent]<img src="/images/dpaf_image14.png" />

### Selección de la base de datos

En el formulario de creación del agente, selecciona la base de datos que acabas de configurar como fuente de datos.

### Selección de tablas

Utiliza la barra de búsqueda para encontrar y seleccionar las tablas que el agente utilizará. El nombre de cada tabla corresponde al nombre del archivo CSV cargado en el Paso 1 (sin la extensión `.csv`).

![Barra de búsqueda de tablas]<img src="/images/dpaf_image15.png" />

![Resultado de búsqueda — tabla "datos"]<img src="/images/dpaf_image16.png" />

> **Ejemplo:** si el archivo se llamaba `datos.csv`, la tabla se llamará `datos`.

Una vez seleccionadas todas las tablas necesarias, haz clic en el botón **Add New Source** para confirmar la selección y avanzar al siguiente paso.

![Botón Add New Source]<img src="/images/dpaf_image17.png" />

### Revisión de la configuración del agente

Revisa el resumen de configuración del agente. Verifica que la base de datos y las tablas seleccionadas sean correctas. Si todo está en orden, haz clic en **Next** para continuar.

![Resumen de configuración del agente]<img src="/images/dpaf_image18.png" />

![Botón Next]<img src="/images/dpaf_image20.png" />

### Publicación del agente

Si la configuración está completa y validada, presiona el botón **Publish Agent** para publicar el agente y dejarlo disponible para su uso.

![Botón Publish Agent]<img src="/images/dpaf_image19.png" />

### Acceso al agente publicado

Una vez publicado, el agente aparecerá listado en el panel de **Data Analysis Agents** del menú izquierdo. Haz clic en **Open Agent** para acceder a él y comenzar a utilizarlo.

---

<a id="sec-3.4.3"></a>
##### 3.4.3 Paso 3 — Uso del agente para análisis de datos

### Apertura del agente

Al hacer clic en **Open Agent**, se abrirá el panel principal del agente, desde donde puedes interactuar con los datos cargados.

![Panel principal del agente]<img src="/images/dpaf_image21.png" />

### Exploración automática de los datos

Haz clic en el botón **Execute Exploration** para que el agente analice automáticamente los datos. Según los tipos de datos detectados en cada columna, el agente generará distintas visualizaciones y gráficas que te permitirán entender la distribución y estructura del dataset.

![Exploración de datos con gráficas]<img src="/images/dpaf_image22.png" />

### Consulta de datos en lenguaje natural

Puedes hacerle preguntas al agente directamente en lenguaje natural. El agente interpretará tu pregunta, generará una consulta SQL sobre la base de datos y te devolverá la respuesta.

> **Ejemplo:** si preguntas *"¿Cuántos equipos participaron?"*, el agente consultará la base de datos y responderá con el número de equipos.

### Visualización de la consulta SQL generada

Para ver la consulta SQL que el agente ejecutó para responder tu pregunta, haz clic en el botón **SQL**. Esto te permite auditar y entender cómo el agente traduce las preguntas a consultas sobre la base de datos.

---

<!-- PASO 4 — CONTINÚA AQUÍ -->
