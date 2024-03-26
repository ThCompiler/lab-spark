# To bump the Spark version, bump the spark_ver in Dockerfile, bump
# this tag and reset to v1. You should also double check the native
# Hadoop libs at that point (we grab the 2.6.1 libs, which are
# appropriate for 1.5.2-with-2.6). Note that you'll need to re-test
# Zeppelin (and it may not have caught up to newest Spark).
TAG = 3.4.2_v1

# To bump the Zeppelin version, bump the version in
# zeppelin/Dockerfile and bump this tag and reset to v1.
ZEPPELIN_TAG = 0.10.0_v1

spark:
	docker build -t thecompiler/spark ./spark_image_build/
	docker tag thecompiler/spark:$(TAG)

zeppelin:
	docker build -t thecompiler/zeppelin ./zeppelin_image_build/
	docker tag -f thecompiler/zeppelin:$(ZEPPELIN_TAG)

push-spark: spark
	docker push thecompiler/spark
	docker push thecompiler/spark:$(TAG)

push-zeppelin: zeppelin
	docker push thecompiler/zeppelin
	docker push thecompiler/zeppelin:$(ZEPPELIN_TAG)

clean:
	docker rmi thecompiler/spark:$(TAG) || :
	docker rmi thecompiler/spark || :

	docker rmi thecompiler/zeppelin:$(ZEPPELIN_TAG) || :
	docker rmi thecompiler/zeppelin || :