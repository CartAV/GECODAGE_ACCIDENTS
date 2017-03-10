SELECT
    "Num_Acc",
    nearest_route.num_route_or_id,
    distance
FROM accidents_pg_prep, 
    LATERAL (SELECT "ID_RTE500", st_distance(geom_acc, the_geom) as distance
     FROM "osm_routes_par_commune" as routes
     where routes.the_geom && st_point(longitude, latitude)
     ORDER BY distance
    LIMIT 1) as nearest_route
