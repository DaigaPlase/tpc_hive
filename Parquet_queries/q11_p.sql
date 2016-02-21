USE tpc_dbase;
drop view q11_part_tmp_cached;
drop view q11_sum_tmp_cached;

create view q11_part_tmp_cached as
select
	ps.partkey,
	sum(ps.supplycost * ps.availqty) as part_value
from
	tpc_partsupp_parq ps,
	tpc_supplier_parq s,
	tpc_nation_parq n
where
	ps.suppkey = s.suppkey
	and s.nationkey = n.nationkey
	and n.name = 'GERMANY'
group by ps.partkey;

create view q11_sum_tmp_cached as
select
	sum(part_value) as total_value
from
	q11_part_tmp_cached;

select
	partkey, part_value as value
from (
	select
		partkey,
		part_value,
		total_value
	from
		q11_part_tmp_cached join q11_sum_tmp_cached
) a
where
	part_value > total_value * 0.0001
order by
	value desc;
