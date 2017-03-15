SELECT
    "Num_Acc",
    nearest_route."INSEE_COM",
    nearest_route.num_route_or_id,
    distance
FROM "caracateristiques_postgis" as caracs

LEFT JOIN LATERAL (SELECT "INSEE_COM", num_route_or_id, st_distance(st_point(longitude, latitude), the_geom) as distance
     FROM "osm_routes_par_commune"  as routes
     where routes.the_geom && st_point(longitude, latitude)
     ORDER BY distance
    LIMIT 1) as nearest_route
ON true

LEFT JOIN "contours_iris"
    ON st_within(st_point(longitude, latitude), the_geom::geometry)