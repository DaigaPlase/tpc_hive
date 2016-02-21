USE tpc_dbase;
select
	c.custkey,
	c.name,
	sum(l.extendedprice * (1 - l.discount)) as revenue,
	c.acctbal,
	n.name,
	c.address,
	c.phone,
	c.comment
from
	tpc_customer_parq c,
	tpc_orders_parq o,
	tpc_lineitem_parq l,
	tpc_nation_parq n
where
	c.custkey = o.custkey
	and l.orderkey = o.orderkey
	and to_date(o.orderdate) >= '1993-07-01'
	and to_date(o.orderdate) < '1993-10-01'
	and l.returnflag = 'R'
	and c.nationkey = n.nationkey
group by
	c.custkey,
	c.name,
	c.acctbal,
	c.phone,
	n.name,
	c.address,
	c.comment
order by
	revenue desc
limit 20;
