-- =======================================
-- CONSULTA 1: Alumnos y datos de su clase
-- =======================================
SELECT
    a.nombre,
    a.correo,
    c.id_cl,
    p.mes,
    ca.lugar
FROM alumnos a
INNER JOIN clase c
    ON a.id_cl = c.id_cl
INNER JOIN promocion p
    ON c.id_pm = p.id_pm
INNER JOIN campus ca
    ON c.id_cam = ca.id_cam
ORDER BY p.mes, a.nombre;


-- ====================================
-- CONSULTA 2: Alumnos de una promoción
-- ====================================
SELECT
    a.nombre,
    a.correo,
    p.mes
FROM alumnos a
INNER JOIN clase c
    ON a.id_cl = c.id_cl
INNER JOIN promocion p
    ON c.id_pm = p.id_pm
WHERE p.mes = 'Mes de la promoción'
ORDER BY a.nombre;


-- =======================================
-- CONSULTA 3: Número de alumnos por clase
-- =======================================
SELECT
    c.id_cl,
    COUNT(a.id_al) AS total_alumnos
FROM clase c
LEFT JOIN alumnos a
    ON c.id_cl = a.id_cl
GROUP BY c.id_cl
ORDER BY total_alumnos DESC;


-- ==========================================
-- CONSULTA 4: Clases impartidas por profesor
-- ==========================================
SELECT
    pf.nombre,
    c.id_cl,
    p.mes
FROM profesores pf
INNER JOIN clase c
    ON pf.id_pf = c.id_pf
INNER JOIN promocion p
    ON c.id_pm = p.id_pm
ORDER BY pf.nombre, c.id_cl;


-- ==================================
-- CONSULTA 5: Proyectos por vertical
-- ==================================
SELECT
    v.nombre_v,
    p.nombre_py
FROM vertical v
INNER JOIN proyectos p
    ON v.id_v = p.id_v
ORDER BY v.nombre_v, p.nombre_py;


-- =====================================
-- CONSULTA 6: Resultados de los alumnos
-- =====================================
SELECT
    a.nombre,
    p.nombre_py,
    r.calificacion
FROM resultados r
INNER JOIN alumnos a
    ON r.id_al = a.id_al
INNER JOIN proyectos p
    ON r.id_py = p.id_py
ORDER BY a.nombre, p.nombre_py;


-- ===============================================
-- CONSULTA 7: Resultados registrados por proyecto
-- ===============================================
SELECT
    p.nombre_py,
    COUNT(r.id_al) AS total_resultados
FROM proyectos p
LEFT JOIN resultados r
    ON p.id_py = r.id_py
GROUP BY p.id_py, p.nombre_py
ORDER BY total_resultados DESC;


-- ====================================================
-- CONSULTA 8: Alumnos con una calificación determinada
-- ====================================================
SELECT
    a.nombre,
    p.nombre_py,
    r.calificacion
FROM resultados r
INNER JOIN alumnos a
    ON r.id_al = a.id_al
INNER JOIN proyectos p
    ON r.id_py = p.id_py
WHERE r.calificacion = 'Apto'
ORDER BY a.nombre;