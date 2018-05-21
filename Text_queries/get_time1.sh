cd /home/sca176/test/queries/a8/t1
source /home/sca176/common-data-lake/tools/dev_test/env.sh
echo "$(date) - ===START Q0_text==="
beeline -u $HIVE_URL -f q0_t.sql > q0_t_result.txt 2>&1
echo "$(date) - ===END Q0_text==="
sleep 1m
echo "$(date) - ===START Q0_avro==="
beeline -u $HIVE_URL -f q0_a.sql > q0_a_result.txt 2>&1
echo "$(date) - ===END Q0_avro==="
sleep 1m
echo "$(date) - ===START Q0_parq==="
beeline -u $HIVE_URL -f q0_p.sql > q0_p_result.txt 2>&1
echo "$(date) - ===END Q0_parq==="
sleep 1m
echo "$(date) - ===START Q23x_text==="
beeline -u $HIVE_URL -f q23x_t.sql > q23x_t_result.txt 2>&1
echo "$(date) - ===END Q23x_text==="
sleep 1m
echo "$(date) - ===START Q23x_avro==="
beeline -u $HIVE_URL -f q23x_a.sql > q23x_a_result.txt 2>&1
echo "$(date) - ===END Q23x_avro==="
sleep 1m
echo "$(date) - ===START Q23x_parq==="
beeline -u $HIVE_URL -f q23x_p.sql > q23x_p_result.txt 2>&1
echo "$(date) - ===END Q23x_parq==="
echo "$(date) - ===END RUN==="