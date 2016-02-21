USE tpc_dbase;
drop view q20_tmp1_cached;
drop view q20_tmp2_cached;
drop view q20_tmp3_cached;
drop view q20_tmp4_cached;

create view q20_tmp1_cached as
select distinct p.partkey
from
	tpc_part_parq p
where
	p.name like 'forest%';

create view q20_tmp2_cached as
select
	l.partkey,
	l.suppkey,
	0.5 * sum(l.quantity) as sum_quantity
from
	tpc_lineitem_parq l
where
	to_date(l.shipdate) >= '1994-01-01'
	and to_date(l.shipdate) < '1995-01-01'
group by l.partkey, l.suppkey;

create view q20_tmp3_cached as
select
	ps.suppkey,
	ps.availqty,
	t2.sum_quantity
from
	tpc_partsupp_parq ps, tpc_part_parq p, q20_tmp1_cached t1, q20_tmp2_cached t2
where
	ps.partkey = p.partkey
	and ps.partkey = t1.partkey
	and ps.suppkey = t2.suppkey;

create view q20_tmp4_cached as
select
	t3.suppkey
from
	q20_tmp3_cached t3
where
	t3.availqty > t3.sum_quantity
group by t3.suppkey;

select
	s.name,
	s.address
from
	tpc_supplier_parq s,
	tpc_nation_parq n,
	q20_tmp4_cached t4
where
	s.nationkey = n.nationkey
	and n.name = 'CANADA'
	and s.suppkey = t4.suppkey
order by s.name;
