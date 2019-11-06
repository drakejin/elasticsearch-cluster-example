#!/bin/bash

# 사용자 사전 및 동의어 업데이트
update_dict() {
  local result_message=`/root/utils/user_dic_download_and_build.sh`
  echo $result_message
  # 서비스 재시작
  if [ $result_message != "" ]; then
    service elasticsearch restart
    exit 0
  else
    exit 1
  fi
}

update_dict