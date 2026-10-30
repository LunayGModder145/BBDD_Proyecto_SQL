--Alumnos que pertenecen a la clase 1
--SELECT alumnos.id_cl, alumnos.nombre, alumnos.correo
--FROM alumnos
--WHERE alumnos.id_cl = 'CL1'

--Numero de Alumnos por campus 
--SELECT campus.lugar, COUNT(alumnos.nombre) AS Numero_alumnos
--FROM alumnos
--JOIN clase
--	ON alumnos.id_cl = clase.id_cl
--JOIN campus
--	ON clase.id_cam = campus.id_cam
--GROUP BY campus.lugar

--Los Profesores de cada campus
--SELECT profesores.nombre, campus.lugar
--FROM profesores
--JOIN clase
--	ON profesores.id_pf = clase.id_pf
--JOIN campus
--	ON clase.id_cam = campus.id_cam

--Numero de Profesores por campus
--SELECT COUNT(profesores.nombre) AS Numero_profes, campus.lugar
--FROM profesores
--JOIN clase
--	ON profesores.id_pf = clase.id_pf
--JOIN campus
--	ON clase.id_cam = campus.id_cam
--GROUP BY campus.lugar

-- CONSULTA 1: Alumnos y datos de su clase
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