while true
do
  echo `date`
  echo `curl -s -XPUT -d '{}' -H "Content-Type: application/json" http://localhost:19211/.kibana_task_manager/_doc/1`
  sleep 0.2
done
