-- Verificacion: debe retornar 31 filas (los bancos, en orden alfabetico)
SELECT a.id  AS area_id,  a.nombre  AS area,
       t.id  AS tipo_id,  t.nombre  AS tipo_parametro,
       p.id  AS param_id, p.nombre  AS entidad,
       p.codigo_abreviacion, p.numero_orden, p.activo
FROM parametros.parametro p
JOIN parametros.tipo_parametro t ON t.id = p.tipo_parametro_id
JOIN parametros.area_tipo      a ON a.id = t.area_tipo_id
WHERE t.nombre = 'Entidades Bancarias'
  AND a.nombre = 'Sector Financiero'
ORDER BY p.numero_orden;

-- Conteo por tabla (esperado: 1 / 1 / 31)
SELECT (SELECT COUNT(*) FROM parametros.area_tipo      WHERE nombre = 'Sector Financiero') AS area_tipo,
       (SELECT COUNT(*) FROM parametros.tipo_parametro WHERE nombre = 'Entidades Bancarias') AS tipo_parametro,
       (SELECT COUNT(*) FROM parametros.parametro p
          JOIN parametros.tipo_parametro t ON t.id = p.tipo_parametro_id
         WHERE t.nombre = 'Entidades Bancarias')                                              AS parametro;

-- Deteccion de duplicados (esperado: 0 filas)
SELECT p.nombre, COUNT(*) AS repeticiones
FROM parametros.parametro p
JOIN parametros.tipo_parametro t ON t.id = p.tipo_parametro_id
WHERE t.nombre = 'Entidades Bancarias'
GROUP BY p.nombre
HAVING COUNT(*) > 1;
