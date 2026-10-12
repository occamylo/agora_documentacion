-- =============================================================================
-- Script   : 02_rollback_entidades_fondo_pension.sql
-- Proposito: Revertir 01_insert_entidades_fondo_pension.sql
-- Orden    : inverso al de insercion (parametro -> tipo_parametro -> area_tipo)
-- Seguridad: no borra el area_tipo si aun tiene otros tipos de parametro.
-- =============================================================================

BEGIN;

DELETE FROM parametros.parametro
WHERE tipo_parametro_id IN (
    SELECT tp.id
    FROM parametros.tipo_parametro tp
    JOIN parametros.area_tipo a ON a.id = tp.area_tipo_id
    WHERE tp.nombre = 'Entidades Fondo de Pensión'
      AND a.nombre  = 'Seguridad Social'
);

DELETE FROM parametros.tipo_parametro
WHERE nombre = 'Entidades Fondo de Pensión'
  AND area_tipo_id IN (
      SELECT id FROM parametros.area_tipo WHERE nombre = 'Seguridad Social'
  );

DELETE FROM parametros.area_tipo a
WHERE a.nombre = 'Seguridad Social'
  AND NOT EXISTS (
      SELECT 1 FROM parametros.tipo_parametro t WHERE t.area_tipo_id = a.id
  );

COMMIT;
