USE tpc_dbase;
select
	l.shipmode,
	sum(case
		when o.orderpriority = '1-URGENT'
			or o.orderpriority = '2-HIGH'
			then 1
		else 0
	end) as high_line_count,
	sum(case
		when o.orderpriority <> '1-URGENT'
			and o.orderpriority <> '2-HIGH'
			then 1
		else 0
	end) as low_line_count
from
	tpc_orders_parq o,
	tpc_lineitem_parq l
where
	o.orderkey = l.orderkey
	and l.shipmode in ('REG AIR', 'MAIL')
	and to_date(l.commitdate) < to_date(l.receiptdate)
	and to_date(l.shipdate) < to_date(l.commitdate)
	and to_date(l.receiptdate) >= '1995-01-01'
	and to_date(l.receiptdate) < '1996-01-01'
group by
	l.shipmode
order by
	l.shipmode;
