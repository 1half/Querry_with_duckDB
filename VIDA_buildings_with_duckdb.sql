
duckdb;

install httpfs;
load httpfs;
install spatial;
load spatial;


SELECT count(*) 
FROM 'https://data.source.coop/vida/google-microsoft-open-buildings/geoparquet/by_country/country_iso=AND/AND.parquet';

DESCRIBE FROM 'https://data.source.coop/vida/google-microsoft-open-buildings/geoparquet/by_country/country_iso=AND/AND.parquet';

SELECT DISTINCT bf_source 
              FROM 'https://data.source.coop/vida/google-microsoft-open-buildings/geoparquet/by_country/country_iso=AND/AND.parquet';

SELECT boundary_id ,area_in_meters
              FROM 'https://data.source.coop/vida/google-microsoft-open-buildings/geoparquet/by_country/country_iso=AND/AND.parquet'
              ORDER BY area_in_meters DESC LIMIT 10;



CREATE OR REPLACE TABLE test_buildings as SELECT bf_source, area_in_meters, ST_GeomFromWKB(geometry) as geom 
        FROM 'https://data.source.coop/vida/google-microsoft-open-buildings/geoparquet/by_country/country_iso=AND/AND.parquet';

    SELECT * FROM test_buildings;
    COPY test_buildings TO 'test_buildings.geojson' WITH (FORMAT GDAL, DRIVER 'GeoJSON', LAYER_CREATION_OPTIONS 'WRITE_BBOX=YES');


       