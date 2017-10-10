SELECT *, ign_commune_france."CODE_COM" as code_arrondissement
  FROM "caracateristiques_postgis"
  LEFT JOIN ign_commune_france
  ON st_within(st_SetSrid(st_point(longitude, latitude), 4326), "the_geom"::geometry)
  AND current_city_code in ('75056', '69123', '13055')