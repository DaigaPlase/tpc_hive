USE dev_grp_base;
select
	n.name,
	sum(l.extendedprice * (1 - l.discount)) as revenue
from
	tpc_customer_avro c,
	tpc_orders_avro o,
	tpc_lineitem_avro l,
	tpc_supplier_avro s,
	tpc_nation_avro n,
	tpc_region_avro r
where
	c.custkey = o.custkey
	and l.orderkey = o.orderkey
	and l.suppkey = s.suppkey
	and c.nationkey = s.nationkey
	and s.nationkey = n.nationkey
	and n.regionkey = r.regionkey
	and r.name = 'AFRICA'
	and to_date(o.orderdate) >= '1993-01-01'
	and to_date(o.orderdate) < '1994-01-01'
group by
	n.name
order by
	revenue desc;
