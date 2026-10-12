-- =============================================================================
-- Script   : 02_rollback_actividades_economicas_ciiu.sql
-- Proposito: Revertir 01_insert_actividades_economicas_ciiu.sql
-- Orden    : inverso al de insercion (parametro -> tipo_parametro -> area_tipo)
-- Seguridad: el area "Información Tributaria" puede ser compartida con otros catalogos
--            tributarios: solo se borra si queda SIN tipos de parametro.
-- =============================================================================

BEGIN;

DELETE FROM parametros.parametro
WHERE tipo_parametro_id IN (
    SELECT tp.id
    FROM parametros.tipo_parametro tp
    JOIN parametros.area_tipo a ON a.id = tp.area_tipo_id
    WHERE tp.nombre = 'Actividades Económicas (CIIU)'
      AND a.nombre  = 'Información Tributaria'
);

DELETE FROM parametros.tipo_parametro
WHERE nombre = 'Actividades Económicas (CIIU)'
  AND area_tipo_id IN (
      SELECT id FROM parametros.area_tipo WHERE nombre = 'Información Tributaria'
  );

DELETE FROM parametros.area_tipo a
WHERE a.nombre = 'Información Tributaria'
  AND NOT EXISTS (
      SELECT 1 FROM parametros.tipo_parametro t WHERE t.area_tipo_id = a.id
  );

COMMIT;
