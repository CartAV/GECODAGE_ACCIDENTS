SELECT *, ign_commune_france."CODE_COM" as code_arrondissement
  FROM "caracateristiques_postgis"
  LEFT JOIN ign_commune_france
  ON st_within(st_SetSrid(st_point(longitude, latitude), 4326), "the_geom"::geometry)
  WHERE "dep" in ('75', '69', '13')
