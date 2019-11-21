while true
do
  echo `date`
  echo `curl -s -XGET http://localhost:19220/.kibana_task_manager/_doc/_search?explain=true`
  sleep 0.2
done
