USE dev_grp_base;
select
	o.orderpriority,
	count(*) as order_count
from
	tpc_orders_dsv o
where
	to_date(o.orderdate) >= '1996-05-01'
	and to_date(o.orderdate) < '1996-08-01'
	and exists (
		select
			*
		from
			tpc_lineitem_dsv l
		where
			l.orderkey = o.orderkey
			and to_date(l.commitdate) < to_date(l.receiptdate)
	)
group by
	o.orderpriority
order by
	o.orderpriority;
