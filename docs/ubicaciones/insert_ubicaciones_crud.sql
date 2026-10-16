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
SELECT
    'Direcciones',
    'Tipos de vía para direcciones',
    'DIRECCIONES',
    TRUE,
    COALESCE((
        SELECT MAX(tp.numero_orden)
        FROM ubicaciones_crud.tipo_lugar tp
    ), 0) + 1,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM ubicaciones_crud.tipo_lugar tp
    WHERE tp.nombre = 'Direcciones'
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
SELECT
    'Interiores',
    'Complementos para direcciones',
    'INTERIORES',
    TRUE,
    COALESCE((
        SELECT MAX(tp.numero_orden)
        FROM ubicaciones_crud.tipo_lugar tp
    ), 0) + 1,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
WHERE NOT EXISTS (
    SELECT 1
    FROM ubicaciones_crud.tipo_lugar tp
    WHERE tp.nombre = 'Interiores'
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
SELECT
    v.nombre,
    tp.id,
    TRUE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM (
    VALUES
        (1, 'Avenida'),
        (2, 'Autopista'),
        (3, 'Calle'),
        (4, 'Carrera'),
        (5, 'Diagonal'),
        (6, 'Transversal')
) AS v(numero_orden, nombre)
JOIN ubicaciones_crud.tipo_lugar tp
    ON tp.nombre = 'Direcciones'
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
SELECT
    v.nombre,
    tp.id,
    TRUE,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM (
    VALUES
        (1, 'Administración'),
        (2, 'Agencia'),
        (3, 'Agrupación'),
        (4, 'Almacén'),
        (5, 'Altillo'),
        (6, 'Apartado'),
        (7, 'Apartamento'),
        (8, 'Barrio'),
        (9, 'Bloque'),
        (10, 'Bodega'),
        (11, 'Bulevar'),
        (12, 'Casa'),
        (13, 'Célula'),
        (14, 'Centro Comercial'),
        (15, 'Circular'),
        (16, 'Circunvalar'),
        (17, 'Ciudadela'),
        (18, 'Conjunto'),
        (19, 'Conjunto Residencial'),
        (20, 'Consultorio'),
        (21, 'Corregimiento'),
        (22, 'Departamento'),
        (23, 'Depósito'),
        (24, 'Depósito Sótano'),
        (25, 'Edificio'),
        (26, 'Entrada'),
        (27, 'Esquina'),
        (28, 'Este'),
        (29, 'Etapa'),
        (30, 'Exterior'),
        (31, 'Finca'),
        (32, 'Garaje'),
        (33, 'Garaje Sótano'),
        (34, 'Hacienda'),
        (35, 'Interior'),
        (36, 'Kilómetro'),
        (37, 'Local'),
        (38, 'Local Mezzanine'),
        (39, 'Lote'),
        (40, 'Manzana'),
        (41, 'Mezzanine'),
        (42, 'Módulo'),
        (43, 'Municipio'),
        (44, 'Norte'),
        (45, 'Occidente'),
        (46, 'Oeste'),
        (47, 'Oficina'),
        (48, 'Oriente'),
        (49, 'Parcela'),
        (50, 'Parque'),
        (51, 'Parqueadero'),
        (52, 'Pasaje'),
        (53, 'Paseo'),
        (54, 'Penthouse'),
        (55, 'Piso'),
        (56, 'Planta'),
        (57, 'Portería'),
        (58, 'Predio'),
        (59, 'Puente'),
        (60, 'Puesto'),
        (61, 'Salón'),
        (62, 'Salón Comunal'),
        (63, 'Sector'),
        (64, 'Semisótano'),
        (65, 'Solar'),
        (66, 'Sótano'),
        (67, 'Suite'),
        (68, 'Supermanzana'),
        (69, 'Sur'),
        (70, 'Terminal'),
        (71, 'Terraza'),
        (72, 'Torre'),
        (73, 'Unidad'),
        (74, 'Unidad Residencial'),
        (75, 'Urbanización'),
        (76, 'Variante'),
        (77, 'Vereda'),
        (78, 'Zona'),
        (79, 'Zona Franca')
) AS v(numero_orden, nombre)
JOIN ubicaciones_crud.tipo_lugar tp
    ON tp.nombre = 'Interiores'
WHERE NOT EXISTS (
    SELECT 1
    FROM ubicaciones_crud.lugar l
    WHERE l.nombre = v.nombre
      AND l.tipo_lugar_id = tp.id
);

COMMIT;