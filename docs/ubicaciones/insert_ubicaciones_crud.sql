BEGIN;
-- ============================================================
-- CATÁLOGOS PARAMÉTRICOS - UBICACIONES CRUD
-- 1. TIPOS DE LUGAR
-- ============================================================
-- ============================================================
-- 1.1 TIPO DE LUGAR: DIRECCIONES
-- ============================================================
INSERT INTO ubicaciones_crud.tipo_lugar (
        nombre,
        descripcion,
        codigo_abreviacion,
        activo,
        numero_orden,
        fecha_creacion,
        fecha_modificacion
    )
SELECT 'DIRECCIONES',
    'Tipos de vía para direcciones',
    'DIRECCIONES',
    TRUE,
    COALESCE(
        (
            SELECT MAX(tp.numero_orden)
            FROM ubicaciones_crud.tipo_lugar tp
        ),
        0
    ) + 1,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
        SELECT 1
        FROM ubicaciones_crud.tipo_lugar tp
        WHERE tp.nombre = 'DIRECCIONES'
    );
-- ============================================================
-- 1.2 TIPO DE LUGAR: INTERIORES
-- ============================================================
INSERT INTO ubicaciones_crud.tipo_lugar (
        nombre,
        descripcion,
        codigo_abreviacion,
        activo,
        numero_orden,
        fecha_creacion,
        fecha_modificacion
    )
SELECT 'INTERIORES',
    'Complementos para direcciones',
    'INTERIORES',
    TRUE,
    COALESCE(
        (
            SELECT MAX(tp.numero_orden)
            FROM ubicaciones_crud.tipo_lugar tp
        ),
        0
    ) + 1,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
        SELECT 1
        FROM ubicaciones_crud.tipo_lugar tp
        WHERE tp.nombre = 'INTERIORES'
    );
-- ============================================================
-- 2.1 OPCIONES DE DIRECCIONES
-- ============================================================
INSERT INTO ubicaciones_crud.lugar (
        nombre,
        tipo_lugar_id,
        activo,
        fecha_creacion,
        fecha_modificacion
    )
SELECT v.nombre,
    tp.id,
    TRUE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM (
        VALUES (1, 'AVENIDA'),
            (2, 'AUTOPISTA'),
            (3, 'CALLE'),
            (4, 'CARRERA'),
            (5, 'DIAGONAL'),
            (6, 'TRANSVERSAL')
    ) AS v(numero_orden, nombre)
    JOIN ubicaciones_crud.tipo_lugar tp ON tp.nombre = 'DIRECCIONES'
WHERE NOT EXISTS (
        SELECT 1
        FROM ubicaciones_crud.lugar l
        WHERE l.nombre = v.nombre
            AND l.tipo_lugar_id = tp.id
    );
-- ============================================================
-- 2.2 OPCIONES DE INTERIORES
-- ============================================================
INSERT INTO ubicaciones_crud.lugar (
        nombre,
        tipo_lugar_id,
        activo,
        fecha_creacion,
        fecha_modificacion
    )
SELECT v.nombre,
    tp.id,
    TRUE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM (
        VALUES (1, 'ADMINISTRACIÓN'),
            (2, 'AGENCIA'),
            (3, 'AGRUPACIÓN'),
            (4, 'ALMACÉN'),
            (5, 'ALTILLO'),
            (6, 'APARTADO'),
            (7, 'APARTAMENTO'),
            (8, 'BARRIO'),
            (9, 'BLOQUE'),
            (10, 'BODEGA'),
            (11, 'BULEVAR'),
            (12, 'CASA'),
            (13, 'CÉLULA'),
            (14, 'CENTRO COMERCIAL'),
            (15, 'CIRCULAR'),
            (16, 'CIRCUNVALAR'),
            (17, 'CIUDADELA'),
            (18, 'CONJUNTO'),
            (19, 'CONJUNTO RESIDENCIAL'),
            (20, 'CONSULTORIO'),
            (21, 'CORREGIMIENTO'),
            (22, 'DEPARTAMENTO'),
            (23, 'DEPÓSITO'),
            (24, 'DEPÓSITO SÓTANO'),
            (25, 'EDIFICIO'),
            (26, 'ENTRADA'),
            (27, 'ESQUINA'),
            (28, 'ESTE'),
            (29, 'ETAPA'),
            (30, 'EXTERIOR'),
            (31, 'FINCA'),
            (32, 'GARAJE'),
            (33, 'GARAJE SÓTANO'),
            (34, 'HACIENDA'),
            (35, 'INTERIOR'),
            (36, 'KILÓMETRO'),
            (37, 'LOCAL'),
            (38, 'LOCAL MEZZANINE'),
            (39, 'LOTE'),
            (40, 'MANZANA'),
            (41, 'MEZZANINE'),
            (42, 'MÓDULO'),
            (43, 'MUNICIPIO'),
            (44, 'NORTE'),
            (45, 'OCCIDENTE'),
            (46, 'OESTE'),
            (47, 'OFICINA'),
            (48, 'ORIENTE'),
            (49, 'PARCELA'),
            (50, 'PARQUE'),
            (51, 'PARQUEADERO'),
            (52, 'PASAJE'),
            (53, 'PASEO'),
            (54, 'PENTHOUSE'),
            (55, 'PISO'),
            (56, 'PLANTA'),
            (57, 'PORTERÍA'),
            (58, 'PREDIO'),
            (59, 'PUENTE'),
            (60, 'PUESTO'),
            (61, 'SALÓN'),
            (62, 'SALÓN COMUNAL'),
            (63, 'SECTOR'),
            (64, 'SEMISÓTANO'),
            (65, 'SOLAR'),
            (66, 'SÓTANO'),
            (67, 'SUITE'),
            (68, 'SUPERMANZANA'),
            (69, 'SUR'),
            (70, 'TERMINAL'),
            (71, 'TERRAZA'),
            (72, 'TORRE'),
            (73, 'UNIDAD'),
            (74, 'UNIDAD RESIDENCIAL'),
            (75, 'URBANIZACIÓN'),
            (76, 'VARIANTE'),
            (77, 'VEREDA'),
            (78, 'ZONA'),
            (79, 'ZONA FRANCA')
    ) AS v(numero_orden, nombre)
    JOIN ubicaciones_crud.tipo_lugar tp ON tp.nombre = 'INTERIORES'
WHERE NOT EXISTS (
        SELECT 1
        FROM ubicaciones_crud.lugar l
        WHERE l.nombre = v.nombre
            AND l.tipo_lugar_id = tp.id
    );
COMMIT;
