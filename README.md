zookeeper-docker
================

To build and test the image, run the commands below.

```sh
docker build -t kafkatest-zookeeper .

docker run --rm --name kafkatest_zookeeper -p 2181:2181 -i kafkatest-zookeeper
```
