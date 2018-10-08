SELECT accidents.*,
       route.num_route_or_id,
       route.num_route_com_id,
       route.st_distance(st_point(accidents.longitude, accidents.latitude), the_geom) AS distance,
       route.geojson,
       route.similarity(accidents.adr, num_route_or_id) AS similarity,
       (CASE WHEN similarity(accidents.adr, route.num_route_or_id) > 0.7
         THEN 0
         ELSE st_distance(st_point(accidents.longitude, accidents.latitude), route.the_geom) * (1 - similarity(accidents.adr, route.num_route_or_id))
         END) AS score
FROM(
    "caracteristiques_coordinates_selected_joined" AS accidents
     LEFT JOIN --LATERAL 
      "osm_routes_par_commune"  AS routes
       )
    ORDER BY score, distance
    LIMIT 1
    ON true
)
