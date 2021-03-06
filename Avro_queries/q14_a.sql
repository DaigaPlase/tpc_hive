USE dev_grp_base;
select
	100.00 * sum(case
		when p.type like 'PROMO%'
			then l.extendedprice * (1 - l.discount)
		else 0
	end) / sum(l.extendedprice * (1 - l.discount)) as promo_revenue
from
	tpc_lineitem_avro l,
	tpc_part_avro p
where
	l.partkey = p.partkey
	and to_date(l.shipdate) >= '1995-08-01' 
	and to_date(l.shipdate) < '1995-09-01';
	
