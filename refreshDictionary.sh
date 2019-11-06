#!/bin/bash

docker exec node_master1 /root/utils/user_dic_download_and_build.sh
docker exec node_data1 /root/utils/user_dic_download_and_build.sh
docker exec node_data2 /root/utils/user_dic_download_and_build.sh
docker exec node_data3 /root/utils/user_dic_download_and_build.sh
docker exec node_data4 /root/utils/user_dic_download_and_build.sh
docker exec node_data5 /root/utils/user_dic_download_and_build.sh
