SELECT *, "CODE_COM" as code_arrondissement
  FROM "caracateristiques_postgis"
  LEFT JOIN "IGN_COMMUNE_FRANCE"
  ON st_within(st_point(longitude, latitude), "the_geom")
