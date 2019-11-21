# master1 => master2 그리고 master2마저도 사라졌을 때

master1 => master2 그리고 master2가 사라졌을때에 어떤 현상들이 발생하는지에 대해 조사해보았다.

# 정리자료

![./docs/killed_master_at_cluster.pptx]

# requirements
- docker, docker-compose


# 수행

0. 월 300만 트래픽 초당 400건의 검색을 하는 서비스라고 생각해보자.

1. cluster 올리기
``` 실행
docker-compose up --build -d
```

2. 테스트 콘솔 및 로그 만들기

- client노드로 쏘는 _cat 명령어
```
./test.cat.to.client.sh
```

- client 노드로 쏘는 _search 명령어

```
./test.search.to.client.sh
```

- data 노드로 쏘는 _search 명령어

```
./test.search.to.data.sh
```

- data 노드로 쏘는 put 명령어

```
./test.put.to.data.sh
```

3. 로그 실시간 보기

```
tail -f test.{something}
```

4. node_master1 죽여보기(2로 스위칭 잘 되나?)

```
docker stop node_master1
```

5. 로그들 한번 살펴봐준다.


6. node_master2 마저도 죽여보기

```
docker stop node_master2
```

7. 로그들 한번 살펴봐준다.

8. node_master2 살려보기

```
docker start node_master2
```

9. kibana에 접속해서 cluster의 상태들을 살펴본다.

```
# chrome에서 http://localhost:15601
```
