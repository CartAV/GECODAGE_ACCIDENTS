SELECT
    "Num_Acc",
    nearest_route."INSEE_COM",
    nearest_route.num_route_or_id,
    distance
FROM "caracateristiques_postgis" as caracs,

LATERAL (SELECT "INSEE_COM", num_route_or_id, st_distance(caracs.the_geom, the_geom) as distance
     FROM "osm_routes_par_commune"  as routes
     where st_dwithin(caracs.the_geom, the_geom, 100)
     ORDER BY distance
    LIMIT 1) as nearest_route

