-- Validaciones de información complementaria — Grupo_9

-- ============================================================
-- VALIDACIONES: INFORMACIÓN COMPLEMENTARIA
-- Grupo: Información Socioeconómica (Grupo_9)
-- ============================================================

-- ============================================================
-- 1. VERIFICACIÓN DE LOS REGISTROS INSERTADOS
-- Resultado esperado: los registros existentes para los códigos
-- definidos, asociados al grupo identificado como Grupo_9.
-- ============================================================

SELECT
    g.id AS grupo_id,
    g.nombre AS grupo_info_complementaria,
    g.codigo_abreviacion AS codigo_grupo,
    i.id AS info_complementaria_id,
    i.nombre AS nombre,
    i.codigo_abreviacion,
    i.activo
FROM terceros.grupo_info_complementaria g
JOIN terceros.info_complementaria i
    ON i.grupo_info_complementaria_id = g.id
WHERE g.codigo_abreviacion = 'Grupo_9'
  AND i.codigo_abreviacion IN (
      'MIGRANTE',
      'VICTIMA_CONFLICTO',
      'PERSONA_PEP',
      'MED_PREPAGADA',
      'CUENTA_AFC',
      'RESPONSABLE_IVA',
      'RESIDE_FIS_COL',
      'PENSION_VOL',
      'TIENE_HIJOS',
      'CABEZA_FAMILIA',
      'PERSONAS_A_CARGO',
      'DECLARANTE_RENTA'
  )
ORDER BY i.nombre;


-- ============================================================
-- 2. CONTEO DE REGISTROS
-- Resultado esperado: 1 grupo identificado como Grupo_9
-- y 12 registros de información complementaria asociados.
-- Los resultados reflejan los datos realmente existentes.
-- ============================================================

SELECT
    (
        SELECT COUNT(*)
        FROM terceros.grupo_info_complementaria
        WHERE codigo_abreviacion = 'Grupo_9'
    ) AS grupos_grupo_9,
    (
        SELECT COUNT(*)
        FROM terceros.info_complementaria i
        JOIN terceros.grupo_info_complementaria g
            ON g.id = i.grupo_info_complementaria_id
        WHERE g.codigo_abreviacion = 'Grupo_9'
          AND i.codigo_abreviacion IN (
              'MIGRANTE',
              'VICTIMA_CONFLICTO',
              'PERSONA_PEP',
              'MED_PREPAGADA',
              'CUENTA_AFC',
              'RESPONSABLE_IVA',
              'RESIDE_FIS_COL',
              'PENSION_VOL',
              'TIENE_HIJOS',
              'CABEZA_FAMILIA',
              'PERSONAS_A_CARGO',
              'DECLARANTE_RENTA'
          )
    ) AS registros_info_complementaria;


-- ============================================================
-- 3. DETECCIÓN DE GRUPOS Grupo_9 DUPLICADOS
-- Resultado esperado: 0 filas.
-- ============================================================

SELECT
    codigo_abreviacion,
    COUNT(*) AS repeticiones
FROM terceros.grupo_info_complementaria
WHERE codigo_abreviacion = 'Grupo_9'
GROUP BY codigo_abreviacion
HAVING COUNT(*) > 1;


-- ============================================================
-- 4. DETECCIÓN DE CÓDIGOS DUPLICADOS DENTRO DE Grupo_9
-- Resultado esperado: 0 filas.
-- Comprueba duplicados entre los códigos definidos para esta tarea.
-- ============================================================

SELECT
    g.codigo_abreviacion AS codigo_grupo,
    i.codigo_abreviacion AS codigo_info_complementaria,
    COUNT(*) AS repeticiones
FROM terceros.info_complementaria i
JOIN terceros.grupo_info_complementaria g
    ON g.id = i.grupo_info_complementaria_id
WHERE g.codigo_abreviacion = 'Grupo_9'
  AND i.codigo_abreviacion IN (
      'MIGRANTE',
      'VICTIMA_CONFLICTO',
      'PERSONA_PEP',
      'MED_PREPAGADA',
      'CUENTA_AFC',
      'RESPONSABLE_IVA',
      'RESIDE_FIS_COL',
      'PENSION_VOL',
      'TIENE_HIJOS',
      'CABEZA_FAMILIA',
      'PERSONAS_A_CARGO',
      'DECLARANTE_RENTA'
  )
GROUP BY
    g.codigo_abreviacion,
    i.codigo_abreviacion
HAVING COUNT(*) > 1
ORDER BY i.codigo_abreviacion;


-- ============================================================
-- 5. DETECCIÓN DE REGISTROS CON CÓDIGOS ESPERADOS EN OTROS GRUPOS
-- Resultado esperado: 0 filas, si todos los registros de esta tarea
-- están asociados exclusivamente a Grupo_9.
-- ============================================================

SELECT
    g.id AS grupo_id,
    g.nombre AS grupo_info_complementaria,
    g.codigo_abreviacion AS codigo_grupo,
    i.id AS info_complementaria_id,
    i.nombre,
    i.codigo_abreviacion
FROM terceros.info_complementaria i
JOIN terceros.grupo_info_complementaria g
    ON g.id = i.grupo_info_complementaria_id
WHERE i.codigo_abreviacion IN (
    'MIGRANTE',
    'VICTIMA_CONFLICTO',
    'PERSONA_PEP',
    'MED_PREPAGADA',
    'CUENTA_AFC',
    'RESPONSABLE_IVA',
    'RESIDE_FIS_COL',
    'PENSION_VOL',
    'TIENE_HIJOS',
    'CABEZA_FAMILIA',
    'PERSONAS_A_CARGO',
    'DECLARANTE_RENTA'
)
AND g.codigo_abreviacion <> 'Grupo_9'
ORDER BY i.codigo_abreviacion;
