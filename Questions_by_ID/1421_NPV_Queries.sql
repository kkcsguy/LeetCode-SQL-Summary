select
    q.id,
    q.year,
    ifnull(n.npv,0) npv
from
    Queries q
    left join
    NPV n using(id,year);
