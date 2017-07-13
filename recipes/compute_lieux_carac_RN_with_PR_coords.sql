SELECT DISTINCT ON (l."Num_Acc") l.*, b.lat, b.lon, b.lat_next, b.lon_next, b."INSEE_COM" as pr_insee_com, b."NOM_COM" as pr_nom_com 
FROM "lieux_caracteristiques_routes_nationales" l
LEFT JOIN "public"."ign_commune_france" icf
ON
    l."current_city_code" = icf."INSEE_COM"
LEFT JOIN  "public"."bornes_routes_borne_suivante_2016" b
ON
    (l.catr = 'autoroute' OR l.catr = 'route nationale') 
    AND l."voie_normalise" = b."nom_courant_route" 
    AND l.pr = b.pr 
    AND ST_DWithin(icf.the_geom::geography, ST_SetSRID(ST_MakePoint(b.lon, b.lat),4326)::geography, 2000)
order by l."Num_Acc", ST_distance(icf.the_geom, ST_SetSRID(ST_MakePoint(b.lon, b.lat),4326))
limit 1000