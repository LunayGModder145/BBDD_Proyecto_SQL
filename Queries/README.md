# Consultas SQL

## 1. Descripción

Este documento recoge las consultas SQL diseñadas para consultar la base de datos del proyecto, desarrollada en PostgreSQL.

Las consultas permiten recuperar información de alumnos, clases, profesores, promociones, campus, proyectos y resultados académicos.


## 2. Consultas disponibles

| N.º | Consulta | Operaciones principales |
|---:|---|---|
| 1 | Alumnos y datos de su clase | `INNER JOIN`, `ORDER BY` |
| 2 | Alumnos de una promoción | `INNER JOIN`, `WHERE` |
| 3 | Número de alumnos por clase | `LEFT JOIN`, `COUNT`, `GROUP BY` |
| 4 | Clases impartidas por profesor | `INNER JOIN` |
| 5 | Proyectos por vertical | `INNER JOIN`, `ORDER BY` |
| 6 | Resultados de los alumnos | `INNER JOIN` |
| 7 | Resultados registrados por proyecto | `LEFT JOIN`, `COUNT`, `GROUP BY` |
| 8 | Alumnos con una calificación determinada | `INNER JOIN`, `WHERE` |


## 3. Detalle de las consultas

### 3.1. Alumnos y datos de su clase

**Objetivo:** obtener el nombre y el email de cada alumno, junto con su clase, promoción y campus.

**Código SQL:**

```sql
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
```

**Explicación:** se relacionan las tablas de alumnos, clases, promociones y campus mediante sus claves primarias y foráneas. Los resultados se ordenan por promoción y nombre del alumno.


### 3.2. Número de alumnos por promoción

**Objetivo:** consultar los alumnos que pertenecen a una promoción determinada.

**Código SQL:**

```sql
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
```

**Explicación:** la consulta relaciona las tablas ALUMNO, CLASE y PROMOCION para identificar la promoción de cada alumno. Mediante WHERE se filtran los resultados para mostrar únicamente los alumnos cuya promoción coincide con el nombre indicado. Los resultados se ordenan alfabéticamente por nombre de alumno.


### 3.3. Número de alumnos por clase

**Objetivo:** consultar cuántos alumnos están asignados a cada clase.

**Código SQL:**

```sql
SELECT
    c.id_cl,
    COUNT(a.id_al) AS total_alumnos
FROM clase c
LEFT JOIN alumnos a
    ON c.id_cl = a.id_cl
GROUP BY c.id_cl
ORDER BY total_alumnos DESC;
```

**Explicación:** se utiliza LEFT JOIN para incluir todas las clases, incluso aquellas que todavía no tengan alumnos asignados. La función COUNT() cuenta los alumnos asociados a cada clase, mientras que GROUP BY agrupa los registros por identificador de clase. Por último, ORDER BY ordena las clases de mayor a menor número de alumnos.


### 3.4. Clases impartidas por cada profesor

**Objetivo:** consultar las clases impartidas por cada profesor y la promoción a la que pertenece cada clase.

**Código SQL:**

```sql
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
```

**Explicación:** la consulta combina las tablas PROFESOR, CLASE y PROMOCION. Mediante las claves foráneas se identifica qué profesor imparte cada clase y a qué promoción está asociada. Los resultados se ordenan por nombre del profesor y por identificador de clase.


### 3.5. Proyectos asociados a cada vertical

**Objetivo:** identificar los proyectos que pertenecen a cada vertical formativa.

**Código SQL:**

```sql
SELECT
    v.nombre_v,
    p.nombre_py
FROM vertical v
INNER JOIN proyectos p
    ON v.id_v = p.id_v
ORDER BY v.nombre_v, p.nombre_py;
```

**Explicación:** se relacionan las tablas VERTICAL y PROYECTO mediante el identificador de la vertical. De este modo, se obtiene el nombre de cada vertical junto con los proyectos asociados. ORDER BY organiza los resultados por nombre de vertical y nombre de proyecto.


### 3.6. Resultados académicos de los alumnos

**Objetivo:** consultar la calificación obtenida por cada alumno en cada proyecto.

**Código SQL:**

```sql
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
```

**Explicación:** la consulta utiliza la tabla RESULTADO como vínculo entre ALUMNO y PROYECTO. Mediante dos operaciones INNER JOIN, se recuperan los nombres del alumno y del proyecto junto con la calificación almacenada. Los resultados se ordenan por nombre del alumno y nombre del proyecto.


### 3.7. Número de resultados registrados por proyecto

**Objetivo:** conocer cuántos resultados de evaluación están registrados para cada proyecto.

**Código SQL:**

```sql
SELECT
    p.nombre_py,
    COUNT(r.id_al) AS total_resultados
FROM proyectos p
LEFT JOIN resultados r
    ON p.id_py = r.id_py
GROUP BY p.id_py, p.nombre_py
ORDER BY total_resultados DESC;
```

**Explicación:** se utiliza LEFT JOIN para incluir también los proyectos que no tengan resultados registrados. La función COUNT() contabiliza los registros de evaluación asociados a cada proyecto, y GROUP BY agrupa los datos por identificador y nombre del proyecto. Finalmente, los proyectos se ordenan de mayor a menor número de resultados.

Esta consulta contabiliza los resultados registrados, no necesariamente el número de alumnos que han superado cada proyecto.


### 3.8. Alumnos con una calificación determinada

**Objetivo:** conocer cuántos resultados de evaluación están registrados para cada proyecto.

**Código SQL:**

```sql
SELECT
    a.nombre,
    p.nombre_py,
    r.calificacion
FROM resultados r
INNER JOIN alumnos a
    ON r.id_al = a.id_al
INNER JOIN proyectos p
    ON r.id_py = p.id_py
WHERE r.calificacion = 'apto'
ORDER BY a.nombre;
```

**Explicación:** la consulta relaciona las tablas RESULTADO, ALUMNO y PROYECTO para obtener el nombre del alumno, el proyecto y su calificación. La cláusula WHERE filtra los registros según la calificación indicada, por ejemplo, apto. Los resultados se ordenan alfabéticamente por nombre del alumno.