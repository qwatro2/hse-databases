insert into stations.cities (name, region)
select
    md5(random()::text),
    md5(random()::text)
from generate_series(1, 100);

