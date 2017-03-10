SELECT 
    "caracteristiques_geocoded_3_postgis".*,
    st_distance("IGN_COMMUNE_FRANCE".the_geom, st_point(long, lat)) as distance_commune_baac,
    st_distance("IGN_COMMUNE_FRANCE".the_geom, st_point(ban_longitude, ban_latitude)) as distance_commune_ban,
    st_distance("IGN_COMMUNE_FRANCE".the_geom, st_point(ban2_longitude, ban2_latitude)) as distance_commune_ban2,
    st_distance("IGN_COMMUNE_FRANCE".the_geom, st_point(bano_longitude, bano_latitude)) as distance_commune_bano,

    "IGN_COMMUNE_FRANCE"."CODE_COM" AS "CODE_COM"
  FROM "caracteristiques_geocoded_3_postgis"
  LEFT JOIN "ign_commune_france" "IGN_COMMUNE_FRANCE"
    ON "caracteristiques_geocoded_3_postgis"."current_city_code" = "IGN_COMMUNE_FRANCE"."INSEE_COM"