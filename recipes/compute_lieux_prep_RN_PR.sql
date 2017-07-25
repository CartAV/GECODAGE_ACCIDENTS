SELECT DISTINCT ON (lc."Num_Acc") 
    lc.*, icf."INSEE_COM" as icf_city_code, 
    b.lat as pr_lat, b.lon as pr_lon, 
    b.lat_next as pr_lat_next1, b.lon_next as pr_lon_next1, 
    b.lat_next2 as pr_lat_next2, b.lon_next2 as pr_lon_next2, 
    b.lat_prev as pr_lat_prev, b.lon_prev as pr_lon_prev, 
    b."INSEE_COM" as pr_insee_com, b."NOM_COM" as pr_nom_com 
FROM "lieux_prep_periph" lc
LEFT JOIN "public"."ign_commune_france" icf
ON
    lc."current_city_code" = icf."INSEE_COM"
LEFT JOIN  "bornes_routes_2016_pour_interpolation" b
ON
    lc."voie_normalise" = b."nom_courant_route" 
    AND lc.pr = b.pr 
    AND ST_DWithin(icf.the_geom::geography, ST_SetSRID(ST_MakePoint(b.lon, b.lat),4326)::geography, 2000)
order by lc."Num_Acc", ST_distance(icf.the_geom, ST_SetSRID(ST_MakePoint(b.lon, b.lat),4326))