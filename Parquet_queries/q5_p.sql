USE tpc_dbase;
select
	n.name,
	sum(l.extendedprice * (1 - l.discount)) as revenue
from
	tpc_customer_parq c,
	tpc_orders_parq o,
	tpc_lineitem_parq l,
	tpc_supplier_parq s,
	tpc_nation_parq n,
	tpc_region_parq r
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
