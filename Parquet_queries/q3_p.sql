USE tpc_dbase;
select
	l.orderkey,
	sum(l.extendedprice * (1 - l.discount)) as revenue,
	o.orderdate,
	o.shippriority
from
	tpc_customer_parq c,
	tpc_orders_parq o,
	tpc_lineitem_parq l
where
	c.mktsegment = 'BUILDING'
	and c.custkey = o.custkey
	and l.orderkey = o.orderkey
	and to_date(o.orderdate) < '1995-03-22'
	and to_date(l.shipdate) > '1995-03-22'
group by
	l.orderkey,
	o.orderdate,
	o.shippriority
order by
	revenue desc,
	o.orderdate
limit 10;
