SELECT
    "Num_Acc",
    "IRIS",
    "CODE_IRIS",
    "INSEE_COM",
    "NOM_IRIS",
    "TYP_IRIS"
FROM "caracateristiques_postgis" as caracs,

LATERAL (SELECT *
     FROM contours_iris as iris
     where st_within( caracs.the_geom::geometry, iris.the_geom::geometry)
         AND "TYP_IRIS" <> 'Z'
    LIMIT 1) as iris

