WITH accidents AS (SELECT acc.*, l.catr FROM "caracteristiques_coordinates_selected" AS acc LEFT JOIN "lieux_postgis" AS l ON acc."Num_Acc" = l."Num_Acc")

SELECT accidents.*,
       nearest_route.*
  FROM accidents

LEFT JOIN LATERAL (SELECT num_route_or_id,
                          num_route_com_id,
                          st_distance(st_point(accidents.longitude, accidents.latitude), the_geom) AS distance,
                          geojson,
                          similarity(accidents.adr, num_route_or_id)
     FROM "osm_routes_par_commune_geojson"  AS routes
     WHERE
        st_dwithin(routes.the_geom, st_point(longitude, latitude), 500)
        AND (
            (accidents.catr = 'autoroute' AND routes.cat_route_osm = 'autoroute')
            OR (accidents.catr = 'route nationale' AND routes.cat_route_osm = 'route principale')
            OR (accidents.catr = 'Boulevard Périphérique' AND routes.cat_route_osm = 'route principale')
            OR (accidents.catr != 'autoroute' AND accidents.catr != 'route nationale' AND accidents.catr != 'Boulevard Périphérique'))
     ORDER BY distance
    LIMIT 1) AS nearest_route
ON true
