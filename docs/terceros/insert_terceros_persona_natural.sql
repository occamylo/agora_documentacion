-- CATÁLOGOS PARAMÉTRICOS - TERCEROS

-- Inserciones de información complementaria — Grupo_9

BEGIN;

-- ============================================================
-- INFORMACIÓN SOCIOECONÓMICA (Grupo_9)
-- ============================================================
-- Cada registro representa un campo de información complementaria.
-- No se crean opciones independientes de "Sí" y "No".
-- Se utiliza el grupo existente identificado por Grupo_9: Información socio económica.

INSERT INTO terceros.info_complementaria (
    nombre,
    grupo_info_complementaria_id,
    activo,
    fecha_creacion,
    fecha_modificacion,
    codigo_abreviacion
)
VALUES
    (
        'Migrante',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE codigo_abreviacion = 'Grupo_9'
        ),
        TRUE,
        NOW(),
        NOW(),
        'MIGRANTE'
    ),
    (
        'Víctima del conflicto',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE codigo_abreviacion = 'Grupo_9'
        ),
        TRUE,
        NOW(),
        NOW(),
        'VICTIMA_CONFLICTO'
    ),
    (
        'Persona expuesta políticamente (PEP)',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE codigo_abreviacion = 'Grupo_9'
        ),
        TRUE,
        NOW(),
        NOW(),
        'PERSONA_PEP'
    ),
    (
        'Posee medicina prepagada actualmente',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE codigo_abreviacion = 'Grupo_9'
        ),
        TRUE,
        NOW(),
        NOW(),
        'MED_PREPAGADA'
    ),
    (
        'Posee cuenta AFC (Ahorro para el Fomento de la Construcción)',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE codigo_abreviacion = 'Grupo_9'
        ),
        TRUE,
        NOW(),
        NOW(),
        'CUENTA_AFC'
    ),
    (
        'Es responsable del IVA',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE codigo_abreviacion = 'Grupo_9'
        ),
        TRUE,
        NOW(),
        NOW(),
        'RESPONSABLE_IVA'
    ),
    (
        'Reside fiscalmente en Colombia',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE codigo_abreviacion = 'Grupo_9'
        ),
        TRUE,
        NOW(),
        NOW(),
        'RESIDE_FIS_COL'
    ),
    (
        'Realiza aportes a pensión voluntaria',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE codigo_abreviacion = 'Grupo_9'
        ),
        TRUE,
        NOW(),
        NOW(),
        'PENSION_VOL'
    );

COMMIT;
