SELECT nom_circo, st_union(the_geom) as the_geom
    FROM "liste_communes_police_postgis",
         "IGN_COMMUNE_FRANCE"
    GROUP BY nom_circo
    