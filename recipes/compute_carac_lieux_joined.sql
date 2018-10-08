SELECT * FROM
    "caracteristiques_coordinates_selected_joined" AS accidents
     LEFT JOIN --LATERAL 
      "osm_routes_par_commune"  AS routes 
    ON true
