#!/bin/bash

# root 권한으로 실행 가정

ES_CONFIG=/usr/share/elasticsearch/config
S3_BUCKET="#####"

# 사용자 사전이나 유의어가 변경된 경우 관련 작업후 데이터 노드 서버 재시작
DIC_URL="${S3_BUCKET}/dict-service-noun"
DIC_PATH="${ES_CONFIG}/nori/dict-service-noun"

DIC_AB_TEST_URL="${S3_BUCKET}/dict-service-noun.ab_test"
DIC_AB_TEST_PATH="${ES_CONFIG}/nori/dict-service-noun.ab_test"

SYNONUM_URL="${S3_BUCKET}/synonym.txt"
SYNONUM_PATH="${ES_CONFIG}/synonym/synonym.txt"

SYNONUM_AB_TEST_URL="${S3_BUCKET}/synonym.ab_test.txt"
SYNONUM_AB_TEST_PATH="${ES_CONFIG}/synonym/synonym.ab_test.txt"

mkdir -p ${ES_CONFIG}/nori
mkdir -p ${ES_CONFIG}/synonym

download_file () {
  curl -so $1 $2
}

# 새로 받을 파일 헤더 변경 시간 및 파일 크기
get_new_file_mtime () {
  local header=$(curl -sI $1)
  local mtime=$(echo "$header" | grep Last-Modified | awk -F 'Last-Modified: ' '{print $2}' | sed 's/\r$//' | date +"%s" -f -)
  echo $mtime
}

get_new_file_size () {
  local header=$(curl -sI $1)
  local size=$(echo "$header" | grep Content-Length | awk -F 'Content-Length: ' '{print $2}' | sed 's/\r$//')
  echo $size
}

# 기존 파일 헤더 변경 시간 및 파일 크기
get_exist_file_mtime () {
  stat -c '%Y' $1
}

get_exist_file_size () {
  stat -c '%s' $1
}

download_if_needed () {
  local new_file_mtime=$(get_new_file_mtime "$1")
  local exist_file_mtime=$(get_exist_file_mtime "$2")

  if [ -z "$exist_file_mtime" ]; then
    exist_file_mtime="0"
  fi

  if [ "$new_file_mtime" -gt "$exist_file_mtime" ]; then
    download_file "$2" "$1"
    return 0
  fi
  return 1
}


diff_and_download () {
  local msg=""

  download_if_needed "$DIC_URL" "$DIC_PATH"
  local dic_changed=$?

  download_if_needed "$SYNONUM_URL" "$SYNONUM_PATH"
  local syn_changed=$?

  download_if_needed "$DIC_AB_TEST_URL" "$DIC_AB_TEST_PATH"
  local dic_ab_test_changed=$?

  download_if_needed "$SYNONUM_AB_TEST_URL" "$SYNONUM_AB_TEST_PATH"
  local syn_ab_test_changed=$?

  if [ "$dic_changed" -eq "0" ]; then
    msg="${msg}\n사용자 사전[Changed]"
  fi

  if [ "$syn_changed" -eq "0" ]; then
    msg="${msg}\n/동의어 사전[Changed]"
  fi

  if [ "$dic_ab_test_changed" -eq "0" ]; then
    msg="${msg}\n/동의어(AB_test) 사전[Changed]"
  fi

  if [ "$syn_ab_test_changed" -eq "0" ]; then
    msg="${msg}\n/동의어(AB_test) 사전[Changed]"
  fi

  echo $msg
}

diff_and_download
