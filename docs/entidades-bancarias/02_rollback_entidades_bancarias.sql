-- =============================================================================
-- Script   : 02_rollback_entidades_bancarias.sql
-- Proposito: Revertir 01_insert_entidades_bancarias.sql
-- Orden    : inverso al de insercion (parametro -> tipo_parametro -> area_tipo)
-- Seguridad: no borra el area_tipo si aun tiene otros tipos de parametro.
-- =============================================================================

BEGIN;

DELETE FROM parametros.parametro
WHERE tipo_parametro_id IN (
    SELECT tp.id
    FROM parametros.tipo_parametro tp
    JOIN parametros.area_tipo a ON a.id = tp.area_tipo_id
    WHERE tp.nombre = 'Entidades Bancarias'
      AND a.nombre  = 'Sector Financiero'
);

DELETE FROM parametros.tipo_parametro
WHERE nombre = 'Entidades Bancarias'
  AND area_tipo_id IN (
      SELECT id FROM parametros.area_tipo WHERE nombre = 'Sector Financiero'
  );

DELETE FROM parametros.area_tipo a
WHERE a.nombre = 'Sector Financiero'
  AND NOT EXISTS (
      SELECT 1 FROM parametros.tipo_parametro t WHERE t.area_tipo_id = a.id
  );

COMMIT;
