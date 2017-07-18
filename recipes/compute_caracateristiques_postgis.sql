SELECT accidents.*,
       nearest_route.num_route_or_id,
       nearest_route.num_route_com_id,
       distance,
       nearest_route.geojson
  FROM "caracteristiques_coordinates_selected" AS accidents

LEFT JOIN LATERAL (SELECT "INSEE_COM", num_route_or_id, num_route_com_id, st_distance(st_point(accidents.longitude, accidents.latitude), the_geom) AS distance, geojson
     FROM "osm_routes_par_commune_geojson"  AS routes
     WHERE
        st_dwithin(routes.the_geom, st_point(longitude, latitude), 500)
        AND (
            (accidents.catr = 'autoroute' AND routes.cat_route_osm = 'autoroute')
            OR (accidents.catr = 'route nationale' AND routes.cat_route_osm = 'route principale')
            OR (accidents.catr != 'autoroute' AND accidents.catr != 'route nationale'))
     ORDER BY distance
    LIMIT 1) AS nearest_route
ON true
