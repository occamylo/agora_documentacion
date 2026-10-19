-- CATÁLOGOS PARAMÉTRICOS - TERCEROS CRUD
-- ============================================================
BEGIN;
-- ============================================================
-- GRUPOS DE INFORMACIÓN COMPLEMENTARIA
-- ============================================================
INSERT INTO terceros.grupo_info_complementaria (
        nombre,
        descripcion,
        codigo_abreviacion,
        activo,
        fecha_creacion,
        fecha_modificacion
    )
VALUES (
        'Migrante',
        'Indica si la persona es migrante.',
        'MIGRANTE',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Víctima del conflicto',
        'Indica si la persona es víctima del conflicto.',
        'VICTIMA_CONFLICTO',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Persona expuesta políticamente (PEP)',
        'Indica si la persona es políticamente expuesta.',
        'PERSONA_EXPUESTA_POLITICAMENTE_PEP',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Posee medicina prepagada actualmente',
        'Indica si la persona tiene medicina prepagada.',
        'MEDICINA_PREPAGADA',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Posee cuenta AFC (Ahorro para el Fomento de la Construcción)',
        'Indica si la persona posee una cuenta AFC.',
        'CUENTA_AFC',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Es responsable del IVA',
        'Indica si la persona es responsable del IVA.',
        'RESPONSABLE_IVA',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Reside fiscalmente en Colombia',
        'Indica si la persona reside fiscalmente en Colombia.',
        'RESIDE_FISCALMENTE_COLOMBIA',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Realiza aportes a pensión voluntaria',
        'Indica si la persona aporta a pensión voluntaria.',
        'APORTES_PENSION_VOLUNTARIA',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Tiene hijos',
        'Indica si la persona tiene hijos.',
        'TIENE_HIJOS',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Cabeza de familia',
        'Indica si la persona es cabeza de familia.',
        'CABEZA_FAMILIA',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Tiene personas a cargo',
        'Indica si la persona tiene personas a cargo.',
        'PERSONAS_A_CARGO',
        TRUE,
        NOW (),
        NOW ()
    ),
    (
        'Declarante de renta',
        'Indica si la persona declara renta.',
        'DECLARANTE_RENTA',
        TRUE,
        NOW (),
        NOW ()
    );
-- ============================================================
-- MIGRANTE
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Migrante'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Migrante'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- VÍCTIMA DEL CONFLICTO
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Víctima del conflicto'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Víctima del conflicto'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- PERSONA EXPUESTA POLÍTICAMENTE (PEP)
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Persona expuesta políticamente (PEP)'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Persona expuesta políticamente (PEP)'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- MEDICINA PREPAGADA
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Posee medicina prepagada actualmente'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Posee medicina prepagada actualmente'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- CUENTA AFC
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Posee cuenta AFC (Ahorro para el Fomento de la Construcción)'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Posee cuenta AFC (Ahorro para el Fomento de la Construcción)'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- RESPONSABLE DEL IVA
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Es responsable del IVA'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Es responsable del IVA'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- RESIDENCIA FISCAL EN COLOMBIA
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Reside fiscalmente en Colombia'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Reside fiscalmente en Colombia'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- APORTES A PENSIÓN VOLUNTARIA
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Realiza aportes a pensión voluntaria'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Realiza aportes a pensión voluntaria'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- TIENE HIJOS
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Tiene hijos'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Tiene hijos'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- CABEZA DE FAMILIA
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Cabeza de familia'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Cabeza de familia'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- PERSONAS A CARGO
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Tiene personas a cargo'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Tiene personas a cargo'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
-- ============================================================
-- DECLARANTE DE RENTA
-- ============================================================
INSERT INTO terceros.info_complementaria (
        nombre,
        grupo_info_complementaria_id,
        activo,
        fecha_creacion,
        fecha_modificacion,
        codigo_abreviacion
    )
VALUES (
        'Sí',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Declarante de renta'
        ),
        TRUE,
        NOW (),
        NOW (),
        'SI'
    ),
    (
        'No',
        (
            SELECT id
            FROM terceros.grupo_info_complementaria
            WHERE nombre = 'Declarante de renta'
        ),
        TRUE,
        NOW (),
        NOW (),
        'NO'
    );
COMMIT;
