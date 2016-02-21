USE tpc_dbase;
select
	sum(l.extendedprice * l.discount) as revenue
from
	tpc_lineitem_parq l
where
	to_date(l.shipdate) >= '1993-01-01'
	and to_date(l.shipdate) < '1994-01-01'
	and l.discount between 0.06 - 0.01 and 0.06 + 0.01
	and l.quantity < 25;
