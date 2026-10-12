-- =============================================================================
-- Script   : 01_insert_cajas_compensacion.sql
-- Proposito: Poblar la BD de parametros con las Cajas de Compensacion Familiar
--            (CCF) que operan en Colombia (42 cajas).
-- Esquema  : parametros
-- Tablas   : area_tipo -> tipo_parametro -> parametro  (orden obligatorio por FK)
-- Motor    : PostgreSQL
-- Idempotente: SI. Se puede ejecutar varias veces sin duplicar registros.
-- Nota     : el area "Seguridad Social" es COMPARTIDA con el script de Entidades Fondo
--            de Pension. Si ya existe, se reutiliza (no se duplica).
-- Supuesto : las columnas "id" tienen secuencia/serial (autoincremental).
-- Fuentes  : Supersubsidio (42 CCF) y UGPP - Listado de CCF (ene-2026).
-- =============================================================================

BEGIN;

-- -----------------------------------------------------------------------------
-- 1. AREA_TIPO  (1 registro; se omite si el area ya existe)
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
--    numero_orden = siguiente disponible dentro del area
-- -----------------------------------------------------------------------------
INSERT INTO parametros.tipo_parametro
    (nombre, descripcion, codigo_abreviacion, activo, numero_orden,
     fecha_creacion, fecha_modificacion, area_tipo_id)
SELECT 'Cajas de Compensación Familiar',
       'Cajas de compensacion familiar que operan en Colombia',
       'CCF',
       TRUE,
       COALESCE((SELECT MAX(tp.numero_orden)
                 FROM parametros.tipo_parametro tp
                 WHERE tp.area_tipo_id = a.id), 0) + 1,
       CURRENT_TIMESTAMP,
       CURRENT_TIMESTAMP,
       a.id
FROM parametros.area_tipo a
WHERE a.nombre = 'Seguridad Social'
  AND NOT EXISTS (
      SELECT 1
      FROM parametros.tipo_parametro t
      WHERE t.nombre = 'Cajas de Compensación Familiar'
        AND t.area_tipo_id = a.id
  );

-- -----------------------------------------------------------------------------
-- 3. PARAMETRO  (42 cajas, asociadas al tipo_parametro anterior)
--    parametro_padre_id = NULL (no hay jerarquia)
--    numero_orden: orden alfabetico (1 a 42)
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
    ('Cafaba', 'Caja de Compensación Familiar de Barrancabermeja - CAFABA', 'CAFABA', 1),
    ('Cafam', 'Caja de Compensación Familiar - CAFAM', 'CAFAM', 2),
    ('Cafamaz', 'Caja de Compensación Familiar del Amazonas - CAFAMAZ', 'CAFAMAZ', 3),
    ('Cafasur', 'Caja de Compensación Familiar del Sur del Tolima - CAFASUR', 'CAFASUR', 4),
    ('Cajacopi Atlántico', 'Caja de Compensación Familiar - CAJACOPI Atlántico', 'CAJACOPI', 5),
    ('Cajamag', 'Caja de Compensación Familiar del Magdalena - CAJAMAG', 'CAJAMAG', 6),
    ('Cajasai', 'Caja de Compensación Familiar de San Andrés y Providencia Islas - CAJASAI', 'CAJASAI', 7),
    ('Cajasan', 'Caja Santandereana de Subsidio Familiar - CAJASAN', 'CAJASAN', 8),
    ('Cofrem', 'Caja de Compensación Familiar - COFREM', 'COFREM', 9),
    ('Colsubsidio', 'Caja Colombiana de Subsidio Familiar - COLSUBSIDIO', 'COLSUBSIDIO', 10),
    ('Combarranquilla', 'Caja de Compensación Familiar de Barranquilla - COMBARRANQUILLA', 'COMBARRANQUILLA', 11),
    ('Comcaja', 'Caja de Compensación Familiar Campesina - COMCAJA', 'COMCAJA', 12),
    ('Comfaboy', 'Caja de Compensación Familiar de Boyacá - COMFABOY', 'COMFABOY', 13),
    ('Comfaca', 'Caja de Compensación Familiar del Caquetá - COMFACA', 'COMFACA', 14),
    ('Comfacasanare', 'Caja de Compensación Familiar del Casanare - COMFACASANARE', 'COMFACASANARE', 15),
    ('Comfacauca', 'Caja de Compensación Familiar del Cauca - COMFACAUCA', 'COMFACAUCA', 16),
    ('Comfacesar', 'Caja de Compensación Familiar del Cesar - COMFACESAR', 'COMFACESAR', 17),
    ('Comfachocó', 'Caja de Compensación Familiar del Chocó - COMFACHOCÓ', 'COMFACHOCO', 18),
    ('Comfacor', 'Caja de Compensación Familiar de Córdoba - COMFACOR', 'COMFACOR', 19),
    ('Comfacundi', 'Caja de Compensación Familiar de Cundinamarca - COMFACUNDI', 'COMFACUNDI', 20),
    ('Comfaguajira', 'Caja de Compensación Familiar de La Guajira - COMFAGUAJIRA', 'COMFAGUAJIRA', 21),
    ('Comfama', 'Caja de Compensación Familiar de Antioquia - COMFAMA', 'COMFAMA', 22),
    ('Comfamiliar Atlántico', 'Caja de Compensación Familiar - COMFAMILIAR Atlántico', 'COMFAMILIAR_ATL', 23),
    ('Comfamiliar Cartagena', 'Caja de Compensación Familiar de Cartagena y Bolívar - COMFAMILIAR', 'COMFAMILIAR_CTG', 24),
    ('Comfamiliar Huila', 'Caja de Compensación Familiar del Huila - COMFAMILIAR', 'COMFAMILIAR_HUILA', 25),
    ('Comfamiliar Nariño', 'Caja de Compensación Familiar de Nariño - COMFAMILIAR', 'COMFAMILIAR_NARINO', 26),
    ('Comfamiliar Putumayo', 'Caja de Compensación Familiar del Putumayo - COMFAMILIAR Putumayo', 'COMFAMILIAR_PUT', 27),
    ('Comfamiliar Risaralda', 'Caja de Compensación Familiar de Risaralda - COMFAMILIAR Risaralda', 'COMFAMILIAR_RIS', 28),
    ('Comfandi', 'Caja de Compensación Familiar del Valle del Cauca Comfamiliar Andi - COMFANDI', 'COMFANDI', 29),
    ('Comfanorte', 'Caja de Compensación Familiar del Norte de Santander - COMFANORTE', 'COMFANORTE', 30),
    ('Comfaoriente', 'Caja de Compensación Familiar del Oriente Colombiano - COMFAORIENTE', 'COMFAORIENTE', 31),
    ('Comfasucre', 'Caja de Compensación Familiar de Sucre - COMFASUCRE', 'COMFASUCRE', 32),
    ('Comfatolima', 'Caja de Compensación Familiar del Tolima - COMFATOLIMA', 'COMFATOLIMA', 33),
    ('Comfenalco Antioquia', 'Caja de Compensación Familiar - COMFENALCO Antioquia', 'COMFENALCO_ANT', 34),
    ('Comfenalco Cartagena', 'Caja de Compensación Familiar de Fenalco - Andi - COMFENALCO Cartagena', 'COMFENALCO_CTG', 35),
    ('Comfenalco Quindío', 'Caja de Compensación Familiar de Fenalco - COMFENALCO Quindío', 'COMFENALCO_QUI', 36),
    ('Comfenalco Santander', 'Caja de Compensación Familiar - COMFENALCO Santander', 'COMFENALCO_SAN', 37),
    ('Comfenalco Tolima', 'Caja de Compensación Familiar de Fenalco del Tolima - COMFENALCO', 'COMFENALCO_TOL', 38),
    ('Comfenalco Valle de la Gente', 'Caja de Compensación Familiar del Valle del Cauca - COMFENALCO Valle de la Gente', 'COMFENALCO_VALLE', 39),
    ('Comfiar', 'Caja de Compensación Familiar de Arauca - COMFIAR', 'COMFIAR', 40),
    ('Compensar', 'Caja de Compensación Familiar - COMPENSAR', 'COMPENSAR', 41),
    ('Confa', 'Caja de Compensación Familiar de Caldas - CONFA', 'CONFA', 42)
) AS v(nombre, descripcion, codigo_abreviacion, numero_orden)
CROSS JOIN (
    SELECT tp.id
    FROM parametros.tipo_parametro tp
    JOIN parametros.area_tipo a ON a.id = tp.area_tipo_id
    WHERE tp.nombre = 'Cajas de Compensación Familiar'
      AND a.nombre  = 'Seguridad Social'
) AS t
WHERE NOT EXISTS (
    SELECT 1
    FROM parametros.parametro p
    WHERE p.tipo_parametro_id = t.id
      AND p.nombre = v.nombre
);

COMMIT;
