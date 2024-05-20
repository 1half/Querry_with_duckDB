
install spatial;
load spatial;
    
CREATE OR REPLACE TABLE chennai_buildings as SELECT bf_source, area_in_meters, ST_GeomFromWKB(geometry) as geom 
    FROM 'https://data.source.coop/vida/google-microsoft-open-buildings/geoparquet/by_country/country_iso=IND/IND.parquet' 
    WHERE st_dwithin(geom,  st_point(80.3,13.1), .1);

SELECT * FROM chennai_buildings;
COPY chennai_buildings TO 'chennai_buildings.geojson' WITH (FORMAT GDAL, DRIVER 'GeoJSON', LAYER_CREATION_OPTIONS 'WRITE_BBOX=YES');
--76a6a5101b7c94dc60a67608906ffc74b8a9762c