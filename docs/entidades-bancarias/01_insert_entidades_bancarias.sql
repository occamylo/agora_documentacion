-- =============================================================================
-- Script   : 01_insert_entidades_bancarias.sql
-- Proposito: Poblar la BD de parametros con las Entidades Bancarias (bancos)
--            vigentes en Colombia.
-- Esquema  : parametros
-- Tablas   : area_tipo -> tipo_parametro -> parametro  (orden obligatorio por FK)
-- Motor    : PostgreSQL
-- Idempotente: SI. Se puede ejecutar varias veces sin duplicar registros.
-- Supuesto : las columnas "id" tienen secuencia/serial (autoincremental).
-- Fuente   : Fogafin - Entidades inscritas (31 bancos), consultada oct-2026.
-- =============================================================================

BEGIN;

-- -----------------------------------------------------------------------------
-- 1. AREA_TIPO  (1 registro)
-- -----------------------------------------------------------------------------
INSERT INTO parametros.area_tipo
    (nombre, descripcion, codigo_abreviacion, activo, numero_orden,
     fecha_creacion, fecha_modificacion)
SELECT 'Sector Financiero',
       'Entidades y conceptos del sector financiero',
       'SF',
       TRUE,
       COALESCE((SELECT MAX(numero_orden) FROM parametros.area_tipo), 0) + 1,
       CURRENT_TIMESTAMP,
       CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM parametros.area_tipo
    WHERE nombre = 'Sector Financiero'
);

-- -----------------------------------------------------------------------------
-- 2. TIPO_PARAMETRO  (1 registro, asociado al area_tipo anterior)
-- -----------------------------------------------------------------------------
INSERT INTO parametros.tipo_parametro
    (nombre, descripcion, codigo_abreviacion, activo, numero_orden,
     fecha_creacion, fecha_modificacion, area_tipo_id)
SELECT 'Entidades Bancarias',
       'Establecimientos bancarios (bancos) que operan en Colombia',
       'EB',
       TRUE,
       1,
       CURRENT_TIMESTAMP,
       CURRENT_TIMESTAMP,
       a.id
FROM parametros.area_tipo a
WHERE a.nombre = 'Sector Financiero'
  AND NOT EXISTS (
      SELECT 1
      FROM parametros.tipo_parametro t
      WHERE t.nombre = 'Entidades Bancarias'
        AND t.area_tipo_id = a.id
  );

-- -----------------------------------------------------------------------------
-- 3. PARAMETRO  (31 bancos, asociados al tipo_parametro anterior)
--    parametro_padre_id = NULL (no hay jerarquia)
--    numero_orden: orden alfabetico (1 a 31)
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
    ('Ban100', 'Ban100 S.A.', 'BAN100', 1),
    ('Banco Agrario de Colombia', 'Banco Agrario de Colombia S.A.', 'AGRARIO', 2),
    ('Banco BBVA Colombia', 'Banco BBVA Colombia S.A.', 'BBVA', 3),
    ('Banco BTG Pactual Colombia', 'Banco BTG Pactual Colombia S.A.', 'BTGPACTUAL', 4),
    ('Banco Caja Social', 'Banco Caja Social S.A.', 'CAJASOCIAL', 5),
    ('Banco Comercial AV Villas', 'Banco Comercial AV Villas S.A.', 'AVVILLAS', 6),
    ('Banco Contactar', 'Banco Contactar S.A.', 'CONTACTAR', 7),
    ('Banco Coomeva', 'Banco Coomeva S.A. (Bancoomeva)', 'COOMEVA', 8),
    ('Banco Cooperativo Coopcentral', 'Banco Cooperativo Coopcentral', 'COOPCENTRAL', 9),
    ('Banco DAVIbank', 'Banco DAVIbank', 'DAVIBANK', 10),
    ('Banco Davivienda', 'Banco Davivienda S.A.', 'DAVIVIENDA', 11),
    ('Banco de Bogotá', 'Banco de Bogotá S.A.', 'BOGOTA', 12),
    ('Banco de la Microempresa de Colombia', 'Banco de la Microempresa de Colombia S.A. (Mibanco)', 'MIBANCO', 13),
    ('Banco de las Microfinanzas - Bancamía', 'Banco de las Microfinanzas - Bancamía S.A.', 'BANCAMIA', 14),
    ('Banco de Occidente', 'Banco de Occidente S.A.', 'OCCIDENTE', 15),
    ('Banco Falabella', 'Banco Falabella S.A.', 'FALABELLA', 16),
    ('Banco Finandina', 'Banco Finandina S.A.', 'FINANDINA', 17),
    ('Banco GNB Sudameris', 'Banco GNB Sudameris S.A.', 'GNBSUDAMERIS', 18),
    ('Banco J.P. Morgan Colombia', 'Banco J.P. Morgan Colombia S.A.', 'JPMORGAN', 19),
    ('Banco Mundo Mujer', 'Banco Mundo Mujer S.A.', 'MUNDOMUJER', 20),
    ('Banco Pichincha', 'Banco Pichincha S.A.', 'PICHINCHA', 21),
    ('Banco Popular', 'Banco Popular S.A.', 'POPULAR', 22),
    ('Banco Santander Colombia', 'Banco Santander Colombia S.A.', 'SANTANDER', 23),
    ('Banco Serfinanza', 'Banco Serfinanza S.A.', 'SERFINANZA', 24),
    ('Banco Unión', 'Banco Unión S.A.', 'UNION', 25),
    ('Banco W', 'Banco W S.A.', 'BANCOW', 26),
    ('Bancolombia', 'Bancolombia S.A.', 'BANCOLOMBIA', 27),
    ('Citibank Colombia', 'Citibank Colombia', 'CITIBANK', 28),
    ('Itaú Colombia', 'Itaú Colombia S.A.', 'ITAU', 29),
    ('Lulo Bank', 'Lulo Bank S.A.', 'LULOBANK', 30),
    ('Revolut Bank Colombia', 'Revolut Bank Colombia S.A.', 'REVOLUT', 31)
) AS v(nombre, descripcion, codigo_abreviacion, numero_orden)
CROSS JOIN (
    SELECT tp.id
    FROM parametros.tipo_parametro tp
    JOIN parametros.area_tipo a ON a.id = tp.area_tipo_id
    WHERE tp.nombre = 'Entidades Bancarias'
      AND a.nombre  = 'Sector Financiero'
) AS t
WHERE NOT EXISTS (
    SELECT 1
    FROM parametros.parametro p
    WHERE p.tipo_parametro_id = t.id
      AND p.nombre = v.nombre
);

COMMIT;
