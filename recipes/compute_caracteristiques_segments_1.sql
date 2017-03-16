SELECT
    "Num_Acc",
    "IRIS",
    "INSEE_COM",
    "NOM_IRIS",
    "IRIS",
    "TYP_IRIS"
FROM "caracateristiques_postgis" as caracs,

LATERAL (SELECT *
     FROM contours_iris as iris
     where st_within(iris.the_geom::geometry, caracs.the_geom::geometry)
    LIMIT 1) as iris

