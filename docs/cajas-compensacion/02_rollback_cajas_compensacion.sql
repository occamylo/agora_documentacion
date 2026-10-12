-- =============================================================================
-- Script   : 02_rollback_cajas_compensacion.sql
-- Proposito: Revertir 01_insert_cajas_compensacion.sql
-- Orden    : inverso al de insercion (parametro -> tipo_parametro -> area_tipo)
-- Seguridad: el area "Seguridad Social" es compartida con otros catalogos (p. ej.
--            Entidades Fondo de Pension): solo se borra si queda SIN tipos.
-- =============================================================================

BEGIN;

DELETE FROM parametros.parametro
WHERE tipo_parametro_id IN (
    SELECT tp.id
    FROM parametros.tipo_parametro tp
    JOIN parametros.area_tipo a ON a.id = tp.area_tipo_id
    WHERE tp.nombre = 'Cajas de Compensación Familiar'
      AND a.nombre  = 'Seguridad Social'
);

DELETE FROM parametros.tipo_parametro
WHERE nombre = 'Cajas de Compensación Familiar'
  AND area_tipo_id IN (
      SELECT id FROM parametros.area_tipo WHERE nombre = 'Seguridad Social'
  );

DELETE FROM parametros.area_tipo a
WHERE a.nombre = 'Seguridad Social'
  AND NOT EXISTS (
      SELECT 1 FROM parametros.tipo_parametro t WHERE t.area_tipo_id = a.id
  );

COMMIT;
