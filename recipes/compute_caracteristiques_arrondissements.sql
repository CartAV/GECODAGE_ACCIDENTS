SELECT *, ign_commune_france."CODE_COM" as code_arrondissement
  FROM "caracateristiques_postgis"
  LEFT JOIN ign_commune_france
  ON st_within(st_point(longitude, latitude)::geography, "the_geom")
