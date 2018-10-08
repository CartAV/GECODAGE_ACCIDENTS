SELECT accidents.*,
       routes.num_route_or_id,
       routes.num_route_com_id,
       routes.st_distance(st_point(accidents.longitude, accidents.latitude), the_geom) AS distance,
       routes.geojson,
       routes.similarity(accidents.adr, routes.num_route_or_id) AS similarity,
       (CASE WHEN similarity(accidents.adr, routes.num_route_or_id) > 0.7
         THEN 0
         ELSE st_distance(st_point(accidents.longitude, accidents.latitude), routes.the_geom) * (1 - similarity(accidents.adr, routes.num_route_or_id))
         END) AS score
FROM "caracteristiques_coordinates_selected_joined" accidents 
LEFT JOIN LATERAL "osm_routes_par_commune"  routes
WHERE st_dwithin(routes.the_geom, st_point(longitude, latitude), 500)
AND ((accidents.catr = 'autoroute' AND routes.cat_route_osm = 'autoroute')
    OR (accidents.catr = 'route nationale' AND routes.cat_route_osm = 'route principale')
    OR (accidents.catr = 'Boulevard Périphérique' AND routes.cat_route_osm = 'route principale')
    OR (accidents.catr != 'autoroute' AND accidents.catr != 'route nationale' AND accidents.catr != 'Boulevard Périphérique')
)
ORDER BY score, distance
LIMIT 1
ON true
