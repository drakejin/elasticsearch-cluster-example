while true
do
  echo `date`
  str=`curl -s -XGET http://localhost:19220/_cat/master`
  read -ra MASTER_MSG <<< "$str"

  let "index=0"
  for i in "${MASTER_MSG[@]}"; do
    if [ $index -eq 3 ]
    then
      echo "$i"
    fi
    let "index=index+1"
  done
  sleep 0.2
done
