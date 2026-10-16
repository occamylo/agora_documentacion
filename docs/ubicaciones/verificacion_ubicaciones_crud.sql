-- ============================================================
-- VERIFICACIÓN 1: CONTEO DE TIPOS Y OPCIONES
-- Esperado: 2 tipos, 6 direcciones y 79 interiores.
-- ============================================================

SELECT
    (
        SELECT COUNT(*)
        FROM ubicaciones_crud.tipo_lugar
        WHERE codigo_abreviacion IN (
            'DIRECCIONES',
            'INTERIORES'
        )
    ) AS tipos_lugar,
    (
        SELECT COUNT(*)
        FROM ubicaciones_crud.lugar l
        JOIN ubicaciones_crud.tipo_lugar tp
            ON tp.id = l.tipo_lugar_id
        WHERE tp.codigo_abreviacion = 'DIRECCIONES'
    ) AS opciones_direcciones,
    (
        SELECT COUNT(*)
        FROM ubicaciones_crud.lugar l
        JOIN ubicaciones_crud.tipo_lugar tp
            ON tp.id = l.tipo_lugar_id
        WHERE tp.codigo_abreviacion = 'INTERIORES'
    ) AS opciones_interiores;

-- Resultado esperado:
-- tipos_lugar = 2
-- opciones_direcciones = 6
-- opciones_interiores = 79


-- ============================================================
-- VERIFICACIÓN 2: MOSTRAR LOS CATÁLOGOS Y SUS OPCIONES
-- Permite revisar las asociaciones y el estado.
-- ============================================================

SELECT
    tp.id AS tipo_lugar_id,
    tp.nombre AS tipo_lugar,
    tp.codigo_abreviacion,
    tp.activo AS tipo_activo,
    tp.numero_orden,
    l.id AS lugar_id,
    l.nombre AS opcion,
    l.activo AS opcion_activa
FROM ubicaciones_crud.tipo_lugar tp
LEFT JOIN ubicaciones_crud.lugar l
    ON l.tipo_lugar_id = tp.id
WHERE tp.codigo_abreviacion IN (
    'DIRECCIONES',
    'INTERIORES'
)
ORDER BY
    tp.numero_orden,
    tp.codigo_abreviacion,
    l.nombre;


-- ============================================================
-- VERIFICACIÓN 3: CÓDIGOS DE TIPO DUPLICADOS
-- Esperado: 0 filas.
-- ============================================================

SELECT
    codigo_abreviacion,
    COUNT(*) AS repeticiones
FROM ubicaciones_crud.tipo_lugar
WHERE codigo_abreviacion IN (
    'DIRECCIONES',
    'INTERIORES'
)
GROUP BY codigo_abreviacion
HAVING COUNT(*) > 1;


-- ============================================================
-- VERIFICACIÓN 4: OPCIONES DUPLICADAS POR TIPO
-- Esperado: 0 filas.
-- ============================================================

SELECT
    tp.nombre AS tipo_lugar,
    l.nombre AS opcion,
    COUNT(*) AS repeticiones
FROM ubicaciones_crud.lugar l
JOIN ubicaciones_crud.tipo_lugar tp
    ON tp.id = l.tipo_lugar_id
WHERE tp.codigo_abreviacion IN (
    'DIRECCIONES',
    'INTERIORES'
)
GROUP BY
    tp.id,
    tp.nombre,
    l.nombre
HAVING COUNT(*) > 1
ORDER BY
    tp.nombre,
    l.nombre;


-- ============================================================
-- VERIFICACIÓN 5: REGISTROS INACTIVOS O CON ORDEN INVÁLIDO
-- En tipo_lugar, se espera 0 filas para tipos inactivos
-- o con numero_orden nulo/no positivo.
-- ============================================================

SELECT
    tp.nombre,
    tp.codigo_abreviacion,
    tp.activo,
    tp.numero_orden
FROM ubicaciones_crud.tipo_lugar tp
WHERE tp.codigo_abreviacion IN (
    'DIRECCIONES',
    'INTERIORES'
)
AND (
    tp.activo IS DISTINCT FROM TRUE
    OR tp.numero_orden IS NULL
    OR tp.numero_orden < 1
);

-- Verificación del estado de las opciones.
-- Esperado: 0 filas.

SELECT
    tp.nombre AS tipo_lugar,
    l.nombre AS opcion,
    l.activo
FROM ubicaciones_crud.lugar l
JOIN ubicaciones_crud.tipo_lugar tp
    ON tp.id = l.tipo_lugar_id
WHERE tp.codigo_abreviacion IN (
    'DIRECCIONES',
    'INTERIORES'
)
AND l.activo IS DISTINCT FROM TRUE;