#!/bin/bash

# root 권한으로 실행 된다고 가정

# 데이터 노드에 설치된 스크립트 실행
remote_command_to_data_node () {
  sudo -u ubuntu ssh -o StrictHostKeyChecking=no -o LogLevel=error ubuntu@$1 'sudo /root/utils/update_and_restart_in_data_node.sh'
}

# rebalancing 활성화
enable_rebalancing() {
  curl -s -X PUT "localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'
    {
      "persistent": {
        "cluster.routing.allocation.enable": "all"
      }
    }
  ' > /dev/null
}

# rebalancing 일시 중지
disable_rebalancing() {
  curl -s -X PUT "localhost:9200/_cluster/settings" -H 'Content-Type: application/json' -d'
    {
      "persistent": {
        "cluster.routing.allocation.enable": "none"
      }
    }
  ' > /dev/null
}

# 데이터 노드들에 원격 접속해서 사전 업데이트 및 재시작
rolling_restart () {
  local data_nodes=$(curl -s localhost:9200/_nodes | jq -r '[.nodes[]] | map(select(.settings.node.data == "true")) | .[] | .ip')
  for data_node in ${data_nodes[@]}; do
    while true; do
      local health=$(curl -s localhost:9200/_cluster/health | jq -r '.status')
      if [ $health == "green" ]; then
        break
      fi
      sleep 5
    done
    disable_rebalancing
    remote_command_to_data_node $data_node
    sleep 30
    enable_rebalancing
  done
}

# 사용자 사전 및 동의어 업데이트
update_dict() {
  local result_message=`/root/utils/user_dic_download_and_build.sh`
  echo $result_message
}

rolling_restart
update_dict
