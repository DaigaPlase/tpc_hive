USE tpc_dbase;
select
	supp_nation,
	cust_nation,
	l_year,
	sum(volume) as revenue
from
	(
		select
			n1.name as supp_nation,
			n2.name as cust_nation,
			year(to_date(l.shipdate)) as l_year,
			l.extendedprice * (1 - l.discount) as volume
		from
			tpc_supplier_parq s,
			tpc_lineitem_parq l,
			tpc_orders_parq o,
			tpc_customer_parq c,
			tpc_nation_parq n1,
			tpc_nation_parq n2
		where
			s.suppkey = l.suppkey
			and o.orderkey = l.orderkey
			and c.custkey = o.custkey
			and s.nationkey = n1.nationkey
			and c.nationkey = n2.nationkey
			and (
				(n1.name = 'KENYA' and n2.name = 'PERU')
				or (n1.name = 'PERU' and n2.name = 'KENYA')
			)
			and to_date(l.shipdate) between '1995-01-01' and '1996-12-31'
	) as shipping
group by
	supp_nation,
	cust_nation,
	l_year
order by
	supp_nation,
	cust_nation,
	l_year;
