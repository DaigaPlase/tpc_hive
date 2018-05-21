USE dev_grp_base;
select
	n.name,
	sum(l.extendedprice * (1 - l.discount)) as revenue
from
	tpc_customer_dsv c,
	tpc_orders_dsv o,
	tpc_lineitem_dsv l,
	tpc_supplier_dsv s,
	tpc_nation_dsv n,
	tpc_region_dsv r
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
