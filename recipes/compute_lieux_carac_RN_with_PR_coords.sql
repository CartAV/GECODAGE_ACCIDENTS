SELECT DISTINCT ON (lc."Num_Acc") lc.*, b.lat as pr_lat, b.lon as pr_lon, b.lat_next as pr_lat_next, b.lon_next as pr_lon_next, b."INSEE_COM" as pr_insee_com, b."NOM_COM" as pr_nom_com 
FROM "lieux_caracteristiques_routes_nationales" lc
LEFT JOIN "ign_commune_france" icf
ON
    lc."current_city_code" = icf."INSEE_COM"
LEFT JOIN  "bornes_routes_borne_suivante_2016" b
ON
    lc."voie_normalise" = b."nom_courant_route" 
    AND lc.pr = b.pr 
    AND ST_DWithin(icf.the_geom::geography, ST_SetSRID(ST_MakePoint(b.lon, b.lat),4326)::geography, 2000)
order by lc."Num_Acc", ST_distance(icf.the_geom, ST_SetSRID(ST_MakePoint(b.lon, b.lat),4326))