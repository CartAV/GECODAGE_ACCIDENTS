SELECT nom_circo, st_union(the_geom::geometry) as the_geom
    FROM "liste_communes_police_postgis",
         ign_commune_france
    GROUP BY nom_circo
    