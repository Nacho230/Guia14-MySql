-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT nombre FROM jugadores ORDER BY nombre;

-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
-- ordenados por nombre alfabéticamente.
SELECT nombre, peso, posicion FROM jugadores
WHERE peso > 200 AND posicion = 'c'
ORDER BY nombre;

-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente. 
SELECT nombre FROM equipos
ORDER BY nombre;

-- 4. Mostrar el nombre de los equipos del este (East).
SELECT nombre, conferencia FROM equipos
WHERE conferencia = 'east';

-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
SELECT nombre, ciudad FROM equipos 
WHERE ciudad LIKE 'c%';

-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT a.nombre, a.nombre_equipo FROM jugadores a
JOIN equipos
ON a.nombre_equipo = equipos.nombre
ORDER BY a.nombre_equipo; 

SELECT nombre, nombre_equipo
FROM jugadores
ORDER BY nombre_equipo;

-- 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT nombre, nombre_equipo FROM jugadores
WHERE nombre_equipo = 'raptors'
ORDER BY nombre;

-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT a.puntos_por_partido, b.nombre
FROM estadisticas a
INNER JOIN jugadores b
ON a.jugador = b.codigo
WHERE b.nombre LIKE 'Pau Gasol';

-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT a.temporada, a.puntos_por_partido, b.nombre
FROM estadisticas a
INNER JOIN jugadores b
ON a.jugador = b.codigo
WHERE b.nombre LIKE 'Pau Gasol' AND a.temporada LIKE '04/05';

-- 10. Mostrar el número de puntos de cada jugador en toda su carrera.
SELECT b.nombre, SUM(a.puntos_por_partido) AS puntos_toda_carrera
FROM estadisticas a
INNER JOIN jugadores b
ON a.jugador = b.codigo
GROUP BY b.nombre;

-- 11. Mostrar el número de jugadores de cada equipo.
SELECT COUNT(codigo) cant_jugadores, nombre_equipo
FROM jugadores 
GROUP BY nombre_equipo
ORDER BY cant_jugadores DESC;

-- 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT b.nombre, ROUND(SUM(a.puntos_por_partido)) AS puntos_toda_carrera
FROM estadisticas a
INNER JOIN jugadores b
ON a.jugador = b.codigo
GROUP BY b.nombre
ORDER BY puntos_toda_carrera DESC
LIMIT 1;

-- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT a.nombre, a.ciudad, a.conferencia, a.division, jugadores.nombre FROM jugadores
INNER JOIN equipos a
ON jugadores.nombre_equipo = a.nombre
WHERE altura = (SELECT MAX(altura) FROM jugadores);


-- 14. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
-- diferencia de puntos.
SELECT equipo_local, equipo_visitante,
ABS(puntos_local - puntos_visitante) AS diferencia_puntos
FROM partidos
ORDER BY diferencia_puntos DESC
LIMIT 1;

-- 15. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
-- equipo_ganador), en caso de empate sera null.
SELECT codigo, equipo_local, equipo_visitante,
CASE
WHEN puntos_local > puntos_visitante THEN 'Ganaron los locales'
WHEN puntos_local < puntos_visitante THEN 'Ganaron los visitantes'
ELSE 'Empataron'
END AS Resultados
FROM partidos;