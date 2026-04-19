# Troubleshooting · DeepDive Workshop OCI 2026

Esta guía cubre problemas comunes al iniciar los notebooks en AIDP.

## 1) Error de esquema en Spark/AIDP

### Síntoma

Al ejecutar una lectura como:

```python
bronze_df = spark.table("deepdivecatalog_bronze.admin.bronze_wc_matches")
```

aparece un error similar a:

`AnalysisException: [SCHEMA_NOT_FOUND] The schema "admin" cannot be found`

### Causa más común

El catálogo externo está resolviendo el esquema en `ORACLE` y no en `ADMIN`.

### Solución recomendada

1. Ejecuta como `ADMIN` el script:
   - `tools/sqltools_oracle_schema_setup.sql`
2. El script:
   - crea/habilita el usuario `ORACLE`
   - crea y carga `ORACLE.BRONZE_WC_MATCHES`
   - habilita ORDS REST para el esquema y la tabla
   - imprime URLs REST de referencia al final
3. En notebooks, usa `oracle` en el path del catálogo:

```python
bronze_df = spark.table("deepdivecatalog_bronze.oracle.bronze_wc_matches")
display(bronze_df.limit(5))
```

### Opción robusta (fallback admin -> oracle)

```python
schema_ok = None

for schema in ["admin", "oracle"]:
    try:
        bronze_df = spark.table(f"deepdivecatalog_bronze.{schema}.bronze_wc_matches")
        schema_ok = schema
        break
    except Exception:
        pass

if schema_ok is None:
    raise Exception("No se encontró la tabla en admin ni oracle")

print(f"Esquema usado: {schema_ok}")
display(bronze_df.limit(5))
```

## 2) Datos cargados pero no visibles

### Síntoma

La tabla existe pero `COUNT(*)` devuelve `0` o AIDP no la ve.

### Solución

Después de `DBMS_CLOUD.COPY_DATA`, ejecuta:

```sql
/
COMMIT;
```

Verifica luego:

```sql
SELECT COUNT(*) AS total_rows
FROM ORACLE.BRONZE_WC_MATCHES;
```


