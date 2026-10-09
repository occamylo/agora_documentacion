-- Verificacion 1: conteo por tabla (esperado: 1 / 1 / 507)
SELECT (SELECT COUNT(*) FROM parametros.area_tipo      WHERE nombre = 'Información Tributaria') AS area_tipo,
       (SELECT COUNT(*) FROM parametros.tipo_parametro WHERE nombre = 'Actividades Económicas (CIIU)') AS tipo_parametro,
       (SELECT COUNT(*) FROM parametros.parametro p
          JOIN parametros.tipo_parametro t ON t.id = p.tipo_parametro_id
         WHERE t.nombre = 'Actividades Económicas (CIIU)')                                              AS parametro;

-- Verificacion 2: muestra de codigos conocidos (esperado: 6 filas)
SELECT p.codigo_abreviacion, p.nombre, p.descripcion, p.numero_orden
FROM parametros.parametro p
JOIN parametros.tipo_parametro t ON t.id = p.tipo_parametro_id
WHERE t.nombre = 'Actividades Económicas (CIIU)'
  AND p.codigo_abreviacion IN ('0010', '0111', '4111', '6201', '6920', '8621')
ORDER BY p.codigo_abreviacion;

-- Verificacion 3: codigos duplicados (esperado: 0 filas)
SELECT p.codigo_abreviacion, COUNT(*) AS repeticiones
FROM parametros.parametro p
JOIN parametros.tipo_parametro t ON t.id = p.tipo_parametro_id
WHERE t.nombre = 'Actividades Económicas (CIIU)'
GROUP BY p.codigo_abreviacion
HAVING COUNT(*) > 1;

-- Verificacion 4: conteo por seccion CIIU (21 secciones + 'Otras clasificaciones DIAN')
SELECT split_part(p.descripcion, ' - ', 2) AS seccion, COUNT(*) AS actividades
FROM parametros.parametro p
JOIN parametros.tipo_parametro t ON t.id = p.tipo_parametro_id
WHERE t.nombre = 'Actividades Económicas (CIIU)'
GROUP BY 1
ORDER BY 1;

-- Verificacion 5: nombres o descripciones que excedan 100 caracteres (esperado: 0 filas)
SELECT p.codigo_abreviacion
FROM parametros.parametro p
JOIN parametros.tipo_parametro t ON t.id = p.tipo_parametro_id
WHERE t.nombre = 'Actividades Económicas (CIIU)'
  AND (LENGTH(p.nombre) > 100 OR LENGTH(p.descripcion) > 100);
