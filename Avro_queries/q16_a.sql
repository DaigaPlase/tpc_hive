USE dev_grp_base;
select
	p.brand,
	p.type,
	p.size,
	count(distinct ps.suppkey) as supplier_cnt
from
	tpc_partsupp_avro ps,
	tpc_part_avro p
where
	p.partkey = ps.partkey
	and p.brand <> 'Brand#34'
	and p.type not like 'ECONOMY BRUSHED%'
	and p.size in (22, 14, 27, 49, 21, 33, 35, 28)
	and ps.suppkey not in (
		select
			s.suppkey
		from
			tpc_supplier_avro s
		where
			s.comment like '%Customer%Complaints%'
	)
group by
	p.brand,
	p.type,
	p.size
order by
	supplier_cnt desc,
	p.brand,
	p.type,
	p.size;
