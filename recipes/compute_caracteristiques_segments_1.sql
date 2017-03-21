SELECT
    "Num_Acc",
    "IRIS",
    "CODE_IRIS",
    "INSEE_COM",
    "NOM_IRIS",
    "TYP_IRIS"
FROM "CONTOURS_IRIS_POPULATION" as caracs,

LATERAL (SELECT *
     FROM contours_iris as iris
     where st_within( caracs.the_geom::geometry, iris.the_geom::geometry)
           AND "TYP_IRIS" <> 'Z' -- les communes Z sont celles trop petites pour être découpées en IRIS
           AND "ban_citycode" = "INSEE_COM"
    LIMIT 1) as iris

