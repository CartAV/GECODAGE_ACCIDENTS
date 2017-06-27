SELECT accidents.*,
       nearest_route.num_route_or_id,
       nearest_route.num_route_com_id,
       distance,
       nearest_route.geojson
  FROM "caracteristiques_coordinates_selected" as accidents

LEFT JOIN LATERAL (SELECT "INSEE_COM", num_route_or_id, num_route_com_id, st_distance(st_point(accidents.longitude, accidents.latitude), the_geom) as distance, geojson
     FROM "osm_routes_par_commune_geojson"  as routes
     where st_dwithin(routes.the_geom, st_point(longitude, latitude), 150)
     ORDER BY distance
    LIMIT 1) as nearest_route
ON true
