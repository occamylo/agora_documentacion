-- -----------------------------------------------------------------------------
-- 1. TIPO_PARAMETRO: Tipos de Cuenta Bancaria
--    Asociado al area_tipo 'Sector Financiero' (SF)
-- -----------------------------------------------------------------------------
INSERT INTO parametros.tipo_parametro
    (nombre, descripcion, codigo_abreviacion, activo, numero_orden,
     fecha_creacion, fecha_modificacion, area_tipo_id)
SELECT 'Tipos de Cuenta Bancaria',
       'Tipos de cuentas bancarias disponibles',
       'TCB',
       TRUE,
       COALESCE((
           SELECT MAX(numero_orden)
           FROM parametros.tipo_parametro
           WHERE area_tipo_id = a.id
       ), 0) + 1,
       CURRENT_TIMESTAMP,
       CURRENT_TIMESTAMP,
       a.id
FROM parametros.area_tipo a
WHERE a.codigo_abreviacion = 'SF'
  AND NOT EXISTS (
      SELECT 1
      FROM parametros.tipo_parametro t
      WHERE t.nombre = 'Tipos de Cuenta Bancaria'
        AND t.area_tipo_id = a.id
  );

-- -----------------------------------------------------------------------------
-- 2. PARAMETROS: Tipos de cuenta bancaria
--    Asociados al tipo_parametro anterior
--    parametro_padre_id = NULL (sin jerarquía)
-- -----------------------------------------------------------------------------
INSERT INTO parametros.parametro
    (nombre, descripcion, codigo_abreviacion, activo, numero_orden,
     fecha_creacion, fecha_modificacion, tipo_parametro_id, parametro_padre_id)
SELECT v.nombre,
       v.descripcion,
       v.codigo_abreviacion,
       TRUE,
       v.numero_orden,
       CURRENT_TIMESTAMP,
       CURRENT_TIMESTAMP,
       t.id,
       NULL
FROM (VALUES
    ('Cuenta de Ahorros', 'Cuenta bancaria de ahorros', 'AHORROS', 1),
    ('Cuenta Corriente', 'Cuenta bancaria corriente', 'CORRIENTE', 2)
) AS v(nombre, descripcion, codigo_abreviacion, numero_orden)
CROSS JOIN (
    SELECT tp.id
    FROM parametros.tipo_parametro tp
    JOIN parametros.area_tipo a ON a.id = tp.area_tipo_id
    WHERE tp.nombre = 'Tipos de Cuenta Bancaria'
      AND a.codigo_abreviacion = 'SF'
) AS t
WHERE NOT EXISTS (
    SELECT 1
    FROM parametros.parametro p
    WHERE p.tipo_parametro_id = t.id
      AND p.nombre = v.nombre
);