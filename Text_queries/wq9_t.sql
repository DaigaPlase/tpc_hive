USE dev_grp_base;
select
	nation,
	o_year,
	sum(amount) as sum_profit
from
	(
		select
			n.name as nation,
			year(o.orderdate) as o_year,
			l.extendedprice * (1 - l.discount) - ps.supplycost * l.quantity as amount
		from
			tpc_part_dsv p,
			tpc_supplier_dsv s,
			tpc_lineitem_dsv l,
			tpc_partsupp_dsv ps,
			tpc_orders_dsv o,
			tpc_nation_dsv n
		where
			s.suppkey = l.suppkey
			and ps.suppkey = l.suppkey
			and ps.partkey = l.partkey
			and p.partkey = l.partkey
			and o.orderkey = l.orderkey
			and s.nationkey = n.nationkey
			and p.name like '%plum%'
	) as profit
group by
	nation,
	o_year
order by
	nation,
	o_year desc;
