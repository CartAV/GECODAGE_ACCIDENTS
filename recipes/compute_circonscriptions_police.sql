SELECT nom_circo, st_union(the_geom::geometry) as the_geom
    FROM "liste_communes_police_postgis",
    INNER JOIN ign_commune_france
        ON insee_com = commune_insee_long
    GROUP BY nom_circo
    