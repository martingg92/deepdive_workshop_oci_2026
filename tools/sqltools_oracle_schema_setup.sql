-- ================================================================
-- DeepDive Workshop OCI 2026
-- SQL Tools Script (alternativo): esquema ORACLE para AIDP
-- Ejecutar primero como ADMIN en Database Actions -> SQL
-- ================================================================
SET SERVEROUTPUT ON;

-- 0) Crear usuario ORACLE (idempotente)
DECLARE
  v_exists NUMBER := 0;
BEGIN
  SELECT COUNT(*) INTO v_exists FROM dba_users WHERE username = 'ORACLE';

  IF v_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE USER ORACLE IDENTIFIED BY "Welcome123456$"';
    EXECUTE IMMEDIATE 'ALTER USER ORACLE QUOTA UNLIMITED ON DATA';
  END IF;
END;
/

-- 1) Permisos base para trabajar objetos y sesiones
BEGIN
  EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO ORACLE';
  EXECUTE IMMEDIATE 'GRANT CREATE TABLE TO ORACLE';
  EXECUTE IMMEDIATE 'GRANT CREATE VIEW TO ORACLE';
  EXECUTE IMMEDIATE 'GRANT CREATE SEQUENCE TO ORACLE';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -1927 THEN -- ORA-01927: grant/revoke failed
      RAISE;
    END IF;
END;
/

-- 2) Habilitar DBMS_CLOUD para el esquema ORACLE (si aplica en tu ADB)
BEGIN
  DBMS_CLOUD_ADMIN.ENABLE_SCHEMA(schema_name => 'ORACLE');
EXCEPTION
  WHEN OTHERS THEN
    -- Puede fallar si ya estaba habilitado o por versión/política.
    -- Se continúa para no detener el script completo.
    NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'GRANT EXECUTE ON DBMS_CLOUD TO ORACLE';
EXCEPTION
  WHEN OTHERS THEN
    -- En algunas versiones no aplica o ya viene concedido.
    NULL;
END;
/

-- 3) Crear tabla en el esquema ORACLE sin cambiar de sesión
BEGIN
  EXECUTE IMMEDIATE q'[
    CREATE TABLE ORACLE.BRONZE_WC_MATCHES (
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
    )
  ]';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -955 THEN -- ORA-00955: name is already used
      RAISE;
    END IF;
END;
/

-- 4) Cargar CSV desde Object Storage al esquema ORACLE
BEGIN
  EXECUTE IMMEDIATE 'ALTER SESSION SET CURRENT_SCHEMA = ORACLE';

  -- Evita duplicados al re-ejecutar el script
  EXECUTE IMMEDIATE 'TRUNCATE TABLE BRONZE_WC_MATCHES';

  DBMS_CLOUD.COPY_DATA(
    table_name      => 'BRONZE_WC_MATCHES',
    credential_name => NULL,
    file_uri_list   => 'https://objectstorage.us-chicago-1.oraclecloud.com/n/axzegnybkron/b/DeepDiveWorkshopData/o/worldcup_matches.csv',
    format          => json_object(
      'type' VALUE 'CSV',
      'skipheaders' VALUE '1'
    )
  );

  EXECUTE IMMEDIATE 'ALTER SESSION SET CURRENT_SCHEMA = ADMIN';
EXCEPTION
  WHEN OTHERS THEN
    EXECUTE IMMEDIATE 'ALTER SESSION SET CURRENT_SCHEMA = ADMIN';
    RAISE;
END;
/
COMMIT;

-- 5) Habilitar ORDS REST para el esquema ORACLE
BEGIN
  ORDS.ENABLE_SCHEMA(
    p_enabled             => TRUE,
    p_schema              => 'ORACLE',
    p_url_mapping_type    => 'BASE_PATH',
    p_url_mapping_pattern => 'oracle',
    p_auto_rest_auth      => FALSE
  );
EXCEPTION
  WHEN OTHERS THEN
    -- Si ya estaba habilitado o cambia por versión, no detenemos el flujo.
    NULL;
END;
/

BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled        => TRUE,
    p_schema         => 'ORACLE',
    p_object         => 'BRONZE_WC_MATCHES',
    p_object_type    => 'TABLE',
    p_object_alias   => 'bronze_wc_matches',
    p_auto_rest_auth => FALSE
  );
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
COMMIT;

-- 6) Validaciones rápidas
SELECT username, account_status
FROM dba_users
WHERE username = 'ORACLE';

SELECT owner, table_name, num_rows
FROM all_tables
WHERE owner = 'ORACLE'
  AND table_name = 'BRONZE_WC_MATCHES';

SELECT COUNT(*) AS total_rows
FROM ORACLE.BRONZE_WC_MATCHES;

-- 7) URL REST al final de la ejecución
DECLARE
  l_db_name VARCHAR2(128);
BEGIN
  SELECT LOWER(name) INTO l_db_name FROM v$database;

  DBMS_OUTPUT.PUT_LINE('--- ORDS REST ---');
  DBMS_OUTPUT.PUT_LINE('Base schema URL (estimada):');
  DBMS_OUTPUT.PUT_LINE('https://' || l_db_name || '.adb.us-chicago-1.oraclecloudapps.com/ords/oracle/');
  DBMS_OUTPUT.PUT_LINE('Recurso tabla:');
  DBMS_OUTPUT.PUT_LINE('https://' || l_db_name || '.adb.us-chicago-1.oraclecloudapps.com/ords/oracle/bronze_wc_matches/');
  DBMS_OUTPUT.PUT_LINE('Nota: si la URL no responde, toma el host de Database Actions y agrega /ords/oracle/');
END;
/

-- Sugerencia para AIDP: usar schema en MAYUSCULA
-- Schema esperado en catalogo externo: ORACLE
