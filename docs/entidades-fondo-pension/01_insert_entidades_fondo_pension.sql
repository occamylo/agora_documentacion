-- =============================================================================
-- Script   : 01_insert_entidades_fondo_pension.sql
-- Proposito: Poblar la BD de parametros con las Entidades Fondo de Pension
--            vigentes en Colombia (RPM + RAIS).
-- Esquema  : parametros
-- Tablas   : area_tipo -> tipo_parametro -> parametro  (orden obligatorio por FK)
-- Motor    : PostgreSQL
-- Idempotente: SI. Se puede ejecutar varias veces sin duplicar registros.
-- Supuesto : las columnas "id" tienen secuencia/serial (autoincremental).
-- =============================================================================

BEGIN;

-- -----------------------------------------------------------------------------
-- 1. AREA_TIPO  (1 registro)
-- -----------------------------------------------------------------------------
INSERT INTO parametros.area_tipo
    (nombre, descripcion, codigo_abreviacion, activo, numero_orden,
     fecha_creacion, fecha_modificacion)
SELECT 'Seguridad Social',
       'Entidades y conceptos del sistema de seguridad social',
       'SS',
       TRUE,
       COALESCE((SELECT MAX(numero_orden) FROM parametros.area_tipo), 0) + 1,
       CURRENT_TIMESTAMP,
       CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM parametros.area_tipo
    WHERE nombre = 'Seguridad Social'
);

-- -----------------------------------------------------------------------------
-- 2. TIPO_PARAMETRO  (1 registro, asociado al area_tipo anterior)
-- -----------------------------------------------------------------------------
INSERT INTO parametros.tipo_parametro
    (nombre, descripcion, codigo_abreviacion, activo, numero_orden,
     fecha_creacion, fecha_modificacion, area_tipo_id)
SELECT 'Entidades Fondo de Pensión',
       'Entidades administradoras de pensiones en Colombia',
       'EFP',
       TRUE,
       1,
       CURRENT_TIMESTAMP,
       CURRENT_TIMESTAMP,
       a.id
FROM parametros.area_tipo a
WHERE a.nombre = 'Seguridad Social'
  AND NOT EXISTS (
      SELECT 1
      FROM parametros.tipo_parametro t
      WHERE t.nombre = 'Entidades Fondo de Pensión'
        AND t.area_tipo_id = a.id
  );

-- -----------------------------------------------------------------------------
-- 3. PARAMETRO  (una fila por entidad, asociadas al tipo_parametro anterior)
--    parametro_padre_id = NULL (no hay jerarquia)
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
    ('Colpensiones', 'Administradora Colombiana de Pensiones - Régimen de Prima Media (RPM)',            'COLPENSIONES', 1),
    ('Porvenir',     'Porvenir S.A. - Régimen de Ahorro Individual con Solidaridad (RAIS)',               'PORVENIR',     2),
    ('Protección',   'Protección S.A. - Régimen de Ahorro Individual con Solidaridad (RAIS)',             'PROTECCION',   3),
    ('Colfondos',    'Colfondos S.A. Pensiones y Cesantías - Régimen de Ahorro Individual (RAIS)',        'COLFONDOS',    4),
    ('Skandia',      'Skandia Pensiones y Cesantías S.A. - Régimen de Ahorro Individual (RAIS)',          'SKANDIA',      5)
) AS v(nombre, descripcion, codigo_abreviacion, numero_orden)
CROSS JOIN (
    SELECT tp.id
    FROM parametros.tipo_parametro tp
    JOIN parametros.area_tipo a ON a.id = tp.area_tipo_id
    WHERE tp.nombre = 'Entidades Fondo de Pensión'
      AND a.nombre  = 'Seguridad Social'
) AS t
WHERE NOT EXISTS (
    SELECT 1
    FROM parametros.parametro p
    WHERE p.tipo_parametro_id = t.id
      AND p.nombre = v.nombre
);

COMMIT;
